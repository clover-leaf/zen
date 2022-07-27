import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_gateway/iot_gateway.dart';
import 'package:iot_repository/iot_repository.dart';
import 'package:json_path/json_path.dart';

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
    on<BrokerListened>(_onBrokerListened);
  }

  /// The IoT repository instance
  final IotRepository repository;

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
  void _onMessagePublishRequested(
    MessagePublishRequested event,
    Emitter<TilesOverviewState> emit,
  ) {
    final device = state.deviceView[event.deviceID];
    if (state.gatewayClient != null && device != null) {
      state.gatewayClient!.published(event.payload, device.topic);
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
      for (final tileConfig in state.tileConfigs) {
        final device = state.deviceView[tileConfig.deviceID];
        if (device != null) {
          // because before gateway client is connected
          // none of topic was subcribed
          // so we subscribe every topic from tileConfigs
          state.gatewayClient!.subscribe(device.topic);
          subscribedTopics[device.topic] = null;
        }
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
    final broker = repository.getBroker();
    final gatewayClient = repository.createClient(broker);

    // Gets initialized projects
    final projects = repository.refreshProject();
    final projectView = {for (final project in projects) project.id: project};

    // initializes projectID
    final projectID = projects.isNotEmpty ? projects.first.id : null;

    // Gets initialized devices
    final devices = repository.refreshDevice();
    final deviceView = {for (final device in devices) device.id: device};

    // Gets initialized tileConfigs
    final tileConfigs = repository.refreshTileConfig();
    final tileConfigView = {
      for (final tileConfig in tileConfigs) tileConfig.id: tileConfig
    };

    // Initializes tile config
    final tileValueView = <FieldId, String?>{};
    for (final tileConfig in tileConfigs) {
      tileValueView[tileConfig.id] = null;
    }

    emit(
      state.copyWith(
        status: TilesOverviewStatus.initialized,
        gatewayClient: gatewayClient,
        projectView: projectView,
        projectID: projectID,
        deviceView: deviceView,
        tileConfigView: tileConfigView,
        tileValueView: tileValueView,
      ),
    );

    add(const BrokerConnectRequested());
    add(const ClientConnectionStatusSubscriptionRequested());
    add(const ProjectSubscriptionRequested());
    add(const DeviceSubscriptionRequested());
    add(const TileConfigSubscriptionRequested());
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
        return state.copyWith(projectView: projectView);
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
        return state.copyWith(deviceView: deviceView);
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
            Map<FieldId, String?>.from(state.subscribedTopics);

        // Creates tileValueView from new data
        final tileConfigView = {
          for (var tileConfig in tileConfigs) tileConfig.id: tileConfig
        };

        // Finds and handles new and edited [TileConfig]
        final newTileConfigs = tileConfigs.where(
          (tileConfig) => !state.tileConfigView.keys.contains(tileConfig.id),
        );
        final edittedTileConfigs = tileConfigs.where(
          (tileConfig) =>
              state.tileConfigView.keys.contains(tileConfig.id) &&
              tileConfig != state.tileConfigView[tileConfig.id],
        );
        for (final tileConfig in [...newTileConfigs, ...edittedTileConfigs]) {
          // Retrieves [Device]
          final device = state.deviceView[tileConfig.deviceID];
          if (device == null) {
            throw Exception('can not find device of tile config');
          }
          // Checks if topic of [Device] is subscribe
          if (!subscribedTopics.keys.contains(device.topic)) {
            // Subscribes topic if gatewayClient has connected successful
            if (state.status.isConnected) {
              state.gatewayClient!.subscribe(device.topic);
              subscribedTopics[device.topic] = null;
            }
            tileValueView[tileConfig.id] = null;
          } else if (subscribedTopics[device.topic] != null) {
            // Gets last message of this topic
            final lastMessage = subscribedTopics[device.topic];
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
          // TODO(me): unsubscribed and delete topic
          //  if there are none tile listen to it
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

  /// mqtt topic publish handle
  Future<void> _onBrokerListened(
    BrokerListened event,
    Emitter<TilesOverviewState> emit,
  ) async {
    try {
      await emit.forEach<List<String>>(
        repository.getPublishMsg(state.gatewayClient!),
        onData: (msg) {
          final tileValueView = Map<FieldId, String?>.from(state.tileValueView);
          final subscribedTopics =
              Map<String, String?>.from(state.subscribedTopics);
          // retrieve info from msg
          // format [topic, payload]
          final topic = msg[0];
          final payload = msg[1];

          // iter through list of tile info to update
          // using for with i counter to get index and better performance
          for (var i = 0; i < state.tileConfigs.length; i++) {
            // retrieve current list of tile info
            final tileConfig = state.tileConfigs[i];
            // retrieve matched mqtt device
            final device = state.deviceView[tileConfig.deviceID];
            if (device == null) {
              throw Exception('cant find device info');
            }
            // check whether brokerID and topic of message matched
            // with brokerID and topic of tile
            if (topic == device.topic) {
              // add payload as last message
              subscribedTopics[topic] = payload;
              // filters payload by tile's type
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
          return state.copyWith(
            tileValueView: tileValueView,
            subscribedTopics: subscribedTopics,
          );
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

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
