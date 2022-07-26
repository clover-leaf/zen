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
    on<Initialized>(_onInitialized);
    on<DeviceSubscriptionRequested>(_onDeviceSubscriptionRequested);
    on<TileConfigSubscriptionRequested>(_onTileConfigSubscriptionRequested);
    on<BrokerListened>(_onBrokerListened);
    on<ActionPublished>(_onActionPublished);
  }

  /// The IoT repository instance
  final IotRepository repository;

  /// Initializes [GatewayClient]
  void _onInitialized(
    Initialized event,
    Emitter<TilesOverviewState> emit,
  ) {
    // Gets initialized broker
    final broker = repository.getBroker();
    final gatewayClient = repository.createClient(broker);

    // Gets initialized projects
    final projects = repository.refreshProject();
    final projectView = {for (final project in projects) project.id: project};

    // Gets initialized devices
    final devices = repository.refreshDevice();
    final deviceView = {for (final device in devices) device.id: device};

    // Gets initialized tileConfigs
    final tileConfigs = repository.refreshTileConfig();
    final tileConfigView = {
      for (final tileConfig in tileConfigs) tileConfig.id: tileConfig
    };

    emit(
      state.copyWith(
        gatewayClient: gatewayClient,
        projectView: projectView,
        deviceView: deviceView,
        tileConfigView: tileConfigView,
      ),
    );
    add(const ProjectSubscriptionRequested());
    add(const DeviceSubscriptionRequested());
    add(const TileConfigSubscriptionRequested());
    add(const BrokerListened());
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
        // <<< Creates copy of tileValueView >>>
        final tileValueView = Map<FieldId, String?>.from(state.tileValueView);

        // <<< Creates tileValueView from new data>>>
        final tileConfigView = {
          for (var tileConfig in tileConfigs) tileConfig.id: tileConfig
        };

        // <<< Finds and handles new [TileConfig] >>>
        final newTileConfigs = tileConfigs.where(
          (tileConfig) => !state.tileConfigView.keys.contains(tileConfig.id),
        );
        for (final tileConfig in newTileConfigs) {
          // <<< Retrieves [Device] >>>
          final device = state.deviceView[tileConfig.deviceID];
          if (device == null) {
            throw Exception('can not find device of tile config');
          }

          // <<< Checks if topic of [Device] is subscribe >>>
          if (!state.subscribedTopics.keys.contains(device.topic)) {
            state.gatewayClient!.subscribe(device.topic);
            tileValueView[tileConfig.id] = null;
          } else {
            // <<< Gets last message of this topic >>>
            final lastMessage = state.subscribedTopics[device.topic];
            // <<< Get [JsonVariable] of new tile >>>
            final jsonVariable = device.jsonVariables.firstWhere(
              (jsonVaribale) =>
                  jsonVaribale.id == tileConfig.tileData.getFieldId(),
              orElse: () => throw Exception('can not find json variable'),
            );
            final value = decodeJsonPayload(
              jsonEnable: device.jsonEnable,
              jsonExtraction: jsonVariable.jsonExtraction,
              payload: lastMessage!,
            );
            tileValueView[tileConfig.id] = value;
          }
        }
        // <<< Finds and handles editted [TileConfig] >>>
        final edittedTileConfigs = tileConfigs.where(
          (tileConfig) =>
              state.tileConfigView.keys.contains(tileConfig.id) &&
              tileConfig != state.tileConfigView[tileConfig.id],
        );
        for (final tileConfig in edittedTileConfigs) {
          // <<< Retrieves [Device] >>>
          final device = state.deviceView[tileConfig.deviceID];
          if (device == null) {
            throw Exception('can not find device of tile config');
          }
          // There are chances that deviceID of tile has change
          // So must check whether its topic was subscribed
          // <<< Checks if topic of [Device] is subscribe >>>
          if (!state.subscribedTopics.keys.contains(device.topic)) {
            state.gatewayClient!.subscribe(device.topic);
            tileValueView[tileConfig.id] = null;
          } else {
            // <<< Gets last message of this topic >>>
            final lastMessage = state.subscribedTopics[device.topic];
            // <<< Get [JsonVariable] of new tile >>>
            final jsonVariable = device.jsonVariables.firstWhere(
              (jsonVaribale) =>
                  jsonVaribale.id == tileConfig.tileData.getFieldId(),
              orElse: () => throw Exception('can not find json variable'),
            );
            final value = decodeJsonPayload(
              jsonEnable: device.jsonEnable,
              jsonExtraction: jsonVariable.jsonExtraction,
              payload: lastMessage!,
            );
            tileValueView[tileConfig.id] = value;
          }
        }
        // <<< Finds and handles deleted [TileConfig] >>>
        final deletedTileConfigs = state.tileConfigs.where(
          (tileConfig) => !tileConfigView.keys.contains(tileConfig.id),
        );
        for (final tileConfig in deletedTileConfigs) {
          // <<< Retrieves [Device] >>>
          final device = state.deviceView[tileConfig.deviceID];
          if (device == null) {
            throw Exception('can not find device of tile config');
          }
          // <<< Checks if topic of [Device] is subscribed >>>
          if (!state.subscribedTopics.keys.contains(device.topic)) {
            tileValueView.remove(tileConfig.id);
          } else {
            // TODO(me): unsubscribed and delete topic if there are none tile listen to it
            tileValueView.remove(tileConfig.id);
          }
        }
        return state.copyWith(
          tileConfigView: tileConfigView,
          tileValueView: tileValueView,
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
              Map<String, String>.from(state.subscribedTopics);
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
              final jsonVariable = device.jsonVariables.firstWhere(
                (jsonVaribale) =>
                    jsonVaribale.id == tileConfig.tileData.getFieldId(),
                orElse: () => throw Exception('can not find json variable'),
              );
              final value = decodeJsonPayload(
                jsonEnable: device.jsonEnable,
                jsonExtraction: jsonVariable.jsonExtraction,
                payload: payload,
              );
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
    required bool jsonEnable,
    required String jsonExtraction,
    required String payload,
  }) {
    if (jsonEnable && jsonExtraction != '') {
      final jsonPath = JsonPath(jsonExtraction);
      final matchedValues =
          jsonPath.read(jsonDecode(payload)).map<String>((JsonPathMatch match) {
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
    } else {
      return payload;
    }
  }

  /// mqtt topic publish handle
  void _onActionPublished(
    ActionPublished event,
    Emitter<TilesOverviewState> emit,
  ) {
    final tileConfig = event.tileConfig;
    final device = state.deviceView[tileConfig.deviceID];
    if (device == null) {
      throw Exception('can not find device');
    }
    // get gateway client of tile
    state.gatewayClient!.published(event.payload, device.topic);
  }
}
