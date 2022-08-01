import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_gateway/iot_gateway.dart';
import 'package:json_path/json_path.dart';
import 'package:user_repository/user_repository.dart';

part 'tiles_overview_event.dart';
part 'tiles_overview_state.dart';

class TilesOverviewBloc extends Bloc<TilesOverviewEvent, TilesOverviewState> {
  TilesOverviewBloc({required this.repository}) : super(TilesOverviewState()) {
    on<InitializeRequested>(_onInitializeRequested);
    on<ClientConnectionStatusSubscriptionRequested>(
      _onConnectionSubcriptionRequested,
    );
    on<MessagePublishRequested>(_onMessagePublishRequested);
    on<ProjectSubscriptionRequested>(_onProjectSubscriptionRequested);
    on<DeviceSubscriptionRequested>(_onDeviceSubscriptionRequested);
    on<TileConfigSubscriptionRequested>(_onTileConfigSubscriptionRequested);
    on<ProjectChangeRequested>(_onProjectChangeRequested);
    on<BrokerConnectRequested>(_onBrokerConnectRequested);
    on<TileConfigDeleteRequested>(_onTileConfigDeleteRequested);
    on<BrokerListened>(_onBrokerListened);
  }

  /// The IoT repository instance
  final UserRepository repository;

  /// Subcribes [Stream] of [List] of [Project]
  Future<void> _onConnectionSubcriptionRequested(
    ClientConnectionStatusSubscriptionRequested event,
    Emitter<TilesOverviewState> emit,
  ) async {
    await emit.forEach<ConnectionStatus>(
      repository.getConnectionStatus(state.gatewayClient!),
      onData: (connectionStatus) {
        if (connectionStatus.isDisconnected) {
          add(const BrokerConnectRequested());
          return state.copyWith(status: TilesOverviewStatus.initialized);
        }
        return state;
      },
    );
  }

  /// Publishes payload to given topic
  Future<void> _onTileConfigDeleteRequested(
    TileConfigDeleteRequested event,
    Emitter<TilesOverviewState> emit,
  ) async {
    await repository.deleteTileConfig(event.tileConfig);
  }

  /// Publishes payload to given topic
  void _onMessagePublishRequested(
    MessagePublishRequested event,
    Emitter<TilesOverviewState> emit,
  ) {
    final device = state.deviceView[event.deviceID];
    if (state.gatewayClient != null && device != null) {
      state.gatewayClient!.published(event.payload, getDeviceTopic(device));
    }
  }

  /// Changes projectID
  void _onProjectChangeRequested(
    ProjectChangeRequested event,
    Emitter<TilesOverviewState> emit,
  ) {
    emit(state.copyWith(projectID: event.projectID));
  }

  /// Connecting to broker
  Future<void> _onBrokerConnectRequested(
    BrokerConnectRequested event,
    Emitter<TilesOverviewState> emit,
  ) async {
    try {
      await state.gatewayClient!.connect();

      final subscribedTopics =
          Map<String, String?>.from(state.subscribedTopics);

      for (final device in state.devices) {
        // because before gateway client is connected or reconnected
        // none of topic was subcribed
        // so we subscribe every topic from tileConfigs
        state.gatewayClient!.subscribe(getDeviceTopic(device));
        // we also subscribe status topic of device
        // state.gatewayClient!.subscribe(formatStatusTopic(device.key));
        subscribedTopics[getDeviceTopic(device)] = null;
        // subscribedTopics[formatStatusTopic(device.key)] = null;
      }
      emit(
        state.copyWith(
          status: TilesOverviewStatus.connected,
          subscribedTopics: subscribedTopics,
        ),
      );
      add(const BrokerListened());
    } catch (e) {
      // Tries to reconnect broker
      add(const BrokerConnectRequested());
    }
  }

  /// Initializes everything
  Future<void> _onInitializeRequested(
    InitializeRequested event,
    Emitter<TilesOverviewState> emit,
  ) async {
    // Gets initialized broker
    await repository.refresh();
    // await repository.getUser();
    add(const ProjectSubscriptionRequested());
    add(const DeviceSubscriptionRequested());
    add(const TileConfigSubscriptionRequested());

    final gatewayClient = repository.createClient();
    add(const BrokerConnectRequested());
    add(const ClientConnectionStatusSubscriptionRequested());
    emit(
      state.copyWith(
        status: TilesOverviewStatus.initialized,
        gatewayClient: gatewayClient,
      ),
    );
  }

  /// Subcribes [Stream] of [List] of [Project]
  Future<void> _onProjectSubscriptionRequested(
    ProjectSubscriptionRequested event,
    Emitter<TilesOverviewState> emit,
  ) async {
    await emit.forEach<List<Project>>(
      repository.getProjects(),
      onData: (projects) {
        final projectView = {for (var project in projects) project.id: project};
        if (state.projectID == null && projects.isNotEmpty) {
          final projectID = projects.first.id;
          return state.copyWith(
            projectView: projectView,
            projectID: projectID,
          );
        } else {
          return state.copyWith(projectView: projectView);
        }
      },
    );
  }

  /// Subcribes [Stream] of [List] of [Device]
  Future<void> _onDeviceSubscriptionRequested(
    DeviceSubscriptionRequested event,
    Emitter<TilesOverviewState> emit,
  ) async {
    await emit.forEach<List<Device>>(
      repository.getDevices(),
      onData: (devices) {
        final deviceView = {for (var device in devices) device.id: device};

        // Creates copy of deviceStatusView
        final deviceStatusView =
            Map<FieldId, bool?>.from(state.deviceStatusView);

        // Creates copy of subscribedTopics
        final subscribedTopics =
            Map<String, String?>.from(state.subscribedTopics);

        // Finds and handles new and edited [Device]
        final newDevice = devices.where(
          (device) => !state.deviceView.keys.contains(device.id),
        );
        final editedDevice = devices.where(
          (device) =>
              state.deviceView.keys.contains(device.id) &&
              device.key != state.deviceView[device.id]?.key,
        );
        for (final device in [...newDevice, ...editedDevice]) {
          // Checks whether topic of [Device] was subscribed or not
          if (!subscribedTopics.keys.contains(formatStatusTopic(device.key))) {
            // Subscribes topic if gatewayClient has connected successful
            if (state.status.isConnected) {
              state.gatewayClient!.subscribe(getDeviceTopic(device));
              // we also subscribe status topic of device
              // state.gatewayClient!.subscribe(formatStatusTopic(device.key));
            }
            subscribedTopics[getDeviceTopic(device)] = null;
            // subscribedTopics[formatStatusTopic(device.key)] = null;
            deviceStatusView[device.id] = null;
          } else {
            // Gets last message of this topic
            final lastMessage = subscribedTopics[formatStatusTopic(device.key)];
            // Get status of [Device]
            final status = decodeStatusPayload(payload: lastMessage);
            deviceStatusView[device.id] = status;
          }
        }
        // Finds and handles deleted [Device]
        final deletedDevices = state.devices.where(
          (device) => !deviceView.keys.contains(device.id),
        );
        for (final device in deletedDevices) {
          if (state.status.isConnected) {
            state.gatewayClient!.unsubscribe(device.key);
            // we also unsubscribe status topic of device
            state.gatewayClient!.unsubscribe(formatStatusTopic(device.key));
          }
          subscribedTopics
            ..remove(device.key)
            ..remove(formatStatusTopic(device.key));
          deviceStatusView.remove(device.id);
        }
        return state.copyWith(
          deviceView: deviceView,
          deviceStatusView: deviceStatusView,
          subscribedTopics: subscribedTopics,
        );
      },
    );
  }

  /// Subcribes [Stream] of [List] of [TileConfig]
  Future<void> _onTileConfigSubscriptionRequested(
    TileConfigSubscriptionRequested event,
    Emitter<TilesOverviewState> emit,
  ) async {
    await emit.forEach<List<TileConfig>>(
      repository.getTileConfigs(),
      onData: (tileConfigs) {
        // Creates copy of tileValueView
        final tileValueView = Map<FieldId, String?>.from(state.tileValueView);

        // Creates copy of subscribedTopics
        final subscribedTopics =
            Map<String, String?>.from(state.subscribedTopics);

        // Creates tileValueView from new data
        final tileConfigView = {
          for (var tileConfig in tileConfigs) tileConfig.id: tileConfig
        };

        // Finds and handles new and edited [TileConfig]
        final newTileConfigs = tileConfigs
            .where(
              (tileConfig) =>
                  !state.tileConfigView.keys.contains(tileConfig.id),
            )
            .toList();
        final editedTileConfigs = tileConfigs
            .where(
              (tileConfig) =>
                  state.tileConfigView.keys.contains(tileConfig.id) &&
                  tileConfig != state.tileConfigView[tileConfig.id],
            )
            .toList();
        for (final tileConfig in [...newTileConfigs, ...editedTileConfigs]) {
          // Retrieves [Device]
          final device = state.deviceView[tileConfig.deviceID];
          if (device == null) {
            throw Exception('can not find device of tile config');
          }
          // At here [Device] are 100% connected
          // so we only check if last message is null or not
          if (subscribedTopics[getDeviceTopic(device)] != null) {
            // Gets last message of this topic
            final lastMessage = subscribedTopics[getDeviceTopic(device)];
            // Get [JsonVariable] of new tile
            late String value;
            if (device.jsonEnable) {
              final jsonVariable = device.jsonVariables.firstWhere(
                (jsonVaribale) =>
                    jsonVaribale.id == tileConfig.tileData.getFieldId(),
                orElse: () => throw Exception('can not find json variable'),
              );
              value = decodeJsonPayload(
                jsonExtraction: jsonVariable.jsonExtraction,
                payload: lastMessage!,
              );
            } else {
              value = lastMessage!;
            }
            tileValueView[tileConfig.id] = value;
          } else {
            tileValueView[tileConfig.id] = null;
          }
        }
        // Finds and handles deleted [TileConfig]
        final deletedTileConfigs = state.tileConfigs.where(
          (tileConfig) => !tileConfigView.keys.contains(tileConfig.id),
        );
        for (final tileConfig in deletedTileConfigs) {
          tileValueView.remove(tileConfig.id);
        }
        return state.copyWith(
          tileConfigView: tileConfigView,
          tileValueView: tileValueView,
          subscribedTopics: subscribedTopics,
        );
      },
    );
  }

  /// handles message from MQTT broker
  Future<void> _onBrokerListened(
    BrokerListened event,
    Emitter<TilesOverviewState> emit,
  ) async {
    try {
      await emit.forEach<List<String>>(
        repository.getPublishMsg(state.gatewayClient!),
        onData: (msg) {
          final tileValueView = Map<FieldId, String?>.from(state.tileValueView);
          final deviceStatusView =
              Map<FieldId, bool?>.from(state.deviceStatusView);

          final subscribedTopics =
              Map<String, String?>.from(state.subscribedTopics);
          // retrieve info from msg
          // format [topic, payload]
          final topic = msg[0];
          final payload = msg[1];

          for (final device in state.devices) {
            if (topic == getDeviceTopic(device)) {
              // add payload as last message
              subscribedTopics[topic] = payload;
              final updatedTileConfigs = state.tileConfigs
                  .where((tileConfig) => tileConfig.deviceID == device.id);
              for (final tileConfig in updatedTileConfigs) {
                late String value;
                if (device.jsonEnable) {
                  final jsonVariable = device.jsonVariables.firstWhere(
                    (jsonVaribale) =>
                        jsonVaribale.id == tileConfig.tileData.getFieldId(),
                    orElse: () => throw Exception('can not find json variable'),
                  );
                  value = decodeJsonPayload(
                    jsonExtraction: jsonVariable.jsonExtraction,
                    payload: payload,
                  );
                } else {
                  value = payload;
                }
                tileValueView[tileConfig.id] = value;
              }
            }
            // handles connection status message
            else if (topic == formatStatusTopic(device.key)) {
              final value = decodeStatusPayload(payload: payload);
              subscribedTopics[formatStatusTopic(device.key)] = payload;
              deviceStatusView[device.id] = value;
            }
          }
          return state.copyWith(
            deviceStatusView: deviceStatusView,
            tileValueView: tileValueView,
            subscribedTopics: subscribedTopics,
          );
        },
      );
    } catch (e) {
      // emit(state.copyWith(status: TilesOverviewStatus.error));
    }
  }

  /// Gets connection status topic from [Device].topic
  String formatStatusTopic(String topic) => '$topic/<<status>>';

  /// Gets topic of [Device]
  String getDeviceTopic(Device device) {
    final project = state.projectView[device.projectID];
    final prefix = '${state.gatewayClient!.broker.username}/feeds';
    return '$prefix/${project!.key}.${device.key}';
  }

  /// Decodes status payload into bool
  bool? decodeStatusPayload({required String? payload}) {
    if (payload != null) {
      final status = decodeJsonPayload(
        jsonExtraction: r'$["status"]',
        payload: payload,
      );
      switch (status) {
        case '0':
          return false;
        case '1':
          return true;
        default:
          return null;
      }
    } else {
      return null;
    }
  }

  /// Decodes message payload into bool
  String decodeJsonPayload({
    required String jsonExtraction,
    required String payload,
  }) {
    if (jsonExtraction != '') {
      try {
        final jsonPath = JsonPath(jsonExtraction);
        final matchedValues = jsonPath
            .read(jsonDecode(payload))
            .map<String>((JsonPathMatch match) {
          final dynamic matchValue = match.value;
          switch (matchValue.runtimeType) {
            case String:
              return matchValue as String;
            default:
              return matchValue.toString();
          }
        });
        if (matchedValues.length != 1) {
          throw Exception('Must only one field matched!');
        }
        return matchedValues.first;
      } catch (e) {
        return '???';
      }
    } else {
      return payload;
    }
  }
}
