import 'dart:convert';
import 'dart:developer';

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
  TilesOverviewBloc({required this.repository})
      : super(TilesOverviewState()) {
    on<BrokerSubscriptionRequested>(_onBrokerSubscriptionRequested);
    on<MqttDeviceSubscriptionRequested>(_onMqttDeviceSubscriptionRequested);
    on<TileConfigSubscriptionRequested>(_onTileConfigSubscriptionRequested);
    on<GatewayClientInitialized>(_onGatewayClientInitialized);
    on<MqttSubscribed>(_onMqttSubscribed);
    on<ActionPublished>(_onActionPublished);
  }

  /// IoT repository instance
  final IotRepository repository;

  /// subcribes brokers
  Future<void> _onBrokerSubscriptionRequested(
    BrokerSubscriptionRequested event,
    Emitter<TilesOverviewState> emit,
  ) async {
    await emit.forEach<List<Broker>>(
      repository.getBrokers(),
      onData: (brokers) {
        final brokerView = {for (var broker in brokers) broker.id: broker};

        if (state.tileConfigs.isEmpty &&
            state.mqttDeviceView.isNotEmpty &&
            state.tileConfigView.isNotEmpty) {
          add(
            GatewayClientInitialized(
              brokerView: brokerView,
              mqttDeviceView: state.mqttDeviceView,
              tileConfigView: state.tileConfigView,
            ),
          );
        }
        return state.copyWith(brokerView: brokerView);
      },
    );
  }

  /// subcribes mqtt devices
  Future<void> _onMqttDeviceSubscriptionRequested(
    MqttDeviceSubscriptionRequested event,
    Emitter<TilesOverviewState> emit,
  ) async {
    await emit.forEach<List<MqttDevice>>(
      repository.getMqttDevices(),
      onData: (mqttDevices) {
        final mqttDeviceView = {
          for (var mqttDevice in mqttDevices) mqttDevice.id: mqttDevice
        };
        if (state.tileConfigs.isEmpty &&
            state.brokerView.isNotEmpty &&
            state.tileConfigView.isNotEmpty) {
          add(
            GatewayClientInitialized(
              brokerView: state.brokerView,
              mqttDeviceView: mqttDeviceView,
              tileConfigView: state.tileConfigView,
            ),
          );
        }
        return state.copyWith(mqttDeviceView: mqttDeviceView);
      },
    );
  }

  /// subcribes mqtt devices
  ///
  /// except when initialized, just one change are made
  Future<void> _onTileConfigSubscriptionRequested(
    TileConfigSubscriptionRequested event,
    Emitter<TilesOverviewState> emit,
  ) async {
    await emit.forEach<List<TileConfig>>(
      repository.getTileConfigs(),
      onData: (tileConfigs) {
        final tileConfigView = {
          for (var tileConfig in tileConfigs) tileConfig.id: tileConfig
        };
        // initialized if not yet
        if (state.tileConfigs.isEmpty &&
            state.brokerView.isNotEmpty &&
            state.mqttDeviceView.isNotEmpty) {
          add(
            GatewayClientInitialized(
              brokerView: state.brokerView,
              mqttDeviceView: state.mqttDeviceView,
              tileConfigView: tileConfigView,
            ),
          );
          return state.copyWith(tileConfigView: tileConfigView);
        }
        // update new tile config
        else {
          final newLength = tileConfigs.length;
          final oldLength = state.tileConfigs.length;
          // new tile config is added
          if (newLength > oldLength) {
            // retrieve map of tile value
            final tileValueView =
                Map<FieldId, String?>.from(state.tileValueView);
            // find new tile config
            final oldIds = state.tileConfigs.map((tileConfig) => tileConfig.id);
            final newTileConfig = tileConfigs.firstWhere(
              (tileConfig) => !oldIds.contains(tileConfig.id),
              orElse: () => throw Exception('more than one change are made'),
            );
            // get device and broker of new tile config
            final device = state.mqttDeviceView[newTileConfig.deviceID];
            if (device == null) {
              throw Exception('can not find device of tile config');
            }
            final broker = state.brokerView[device.brokerID];
            if (broker == null) {
              throw Exception('can not find device of tile config');
            }
            // brokerId: gatewayclient
            final brokerIdGatewayClientMap = {
              for (final gatewayClient in state.gatewayClients)
                gatewayClient.broker.id: gatewayClient
            };
            // if state have gateway client that connected with this broker
            if (brokerIdGatewayClientMap.keys.contains(broker.id)) {
              final subscribedTopicKey =
                  generateSubscribeTopicKey(broker, device);
              // if this topic have subscribed than
              // retrieve value from last message
              if (state.subscribedTopics.keys.contains(subscribedTopicKey)) {
                final payload = state.subscribedTopics[subscribedTopicKey]!;
                late String value;
                if (newTileConfig.tileType == TileType.text) {
                  value = decodeJsonPayload(
                    jsonEnable:
                        (newTileConfig.tileData as TextTileData).jsonEnable,
                    jsonExtraction:
                        (newTileConfig.tileData as TextTileData).jsonExtraction,
                    payload: payload,
                  );
                } else if (newTileConfig.tileType == TileType.toggle) {
                  value = decodeJsonPayload(
                    jsonEnable:
                        (newTileConfig.tileData as ToggleTileData).jsonEnable,
                    jsonExtraction: (newTileConfig.tileData as ToggleTileData)
                        .jsonExtraction,
                    payload: payload,
                  );
                } else {
                  value = '';
                }
                tileValueView[newTileConfig.id] = value;
                return state.copyWith(
                  tileConfigView: tileConfigView,
                  tileValueView: tileValueView,
                );
              }
              // else subscribed it
              else {
                // copy subscribedTopics
                final subscribedTopics =
                    Map<String, String>.from(state.subscribedTopics);
                // retrieve gateway client
                final gatewayClient = brokerIdGatewayClientMap[broker.id];
                if (gatewayClient == null) {
                  throw Exception('can not find gateway client');
                }
                gatewayClient.subscribe(device.topic);
                // add subscribed topic and empty last message
                final subscribedTopicKey = generateSubscribeTopicKey(
                  gatewayClient.broker,
                  device,
                );
                subscribedTopics[subscribedTopicKey] = '';
                return state.copyWith(
                  tileConfigView: tileConfigView,
                  subscribedTopics: subscribedTopics,
                );
              }
            }
            // else connect to broker
            else {}
          }
          // one tile config is changed
          else if (newLength == oldLength) {
          }
          // one tile config is deleted
          else {}
          return state;
        }
      },
    );
  }

  /// mqtt initialize handle
  Future<void> _onGatewayClientInitialized(
    GatewayClientInitialized event,
    Emitter<TilesOverviewState> emit,
  ) async {
    try {
      // initialize empty tile values
      final tileConfigs = [...event.tileConfigView.values];
      final tileValueView = {
        for (var tileConfig in tileConfigs) tileConfig.id: null
      };

      // create empty gateway client
      final gatewayClients = <GatewayClient>[];
      // retrieve unique broker id list that devices required
      final usedBrokerIDs =
          state.mqttDevices.map((device) => device.brokerID).toSet();
      // build list gatewway client by iter through unique broker id list
      for (final brokerID in usedBrokerIDs) {
        // find matched ID broker in brokers
        final broker = state.brokerView[brokerID];
        if (broker == null) {
          throw Exception('cant find broker info');
        }
        // initialize gateway client with matched broker
        final gatewayClient = repository.createClient(broker);
        // MUST login
        await gatewayClient.login();
        gatewayClients.add(gatewayClient);
      }

      // initialize gateway client view
      final gatewayClientView = {
        for (var gatewayClient in gatewayClients)
          gatewayClient.broker.id: gatewayClient
      };

      // initialize subscribed topic map
      final subscribedTopics = <String, String>{};
      for (final tileConfig in tileConfigs) {
        final device = state.mqttDeviceView[tileConfig.deviceID];
        if (device == null) {
          throw Exception('cant find device info');
        }
        final gatewayClient = gatewayClientView[device.brokerID];
        if (gatewayClient == null) {
          throw Exception('cant find gateway client info');
        }
        gatewayClient.subscribe(device.topic);

        // add subscribed topic and empty last message
        final subscribedTopicKey = generateSubscribeTopicKey(
          gatewayClient.broker,
          device,
        );
        subscribedTopics[subscribedTopicKey] = '';
      }

      emit(
        state.copyWith(
          status: TilesOverviewStatus.success,
          gatewayClientView: gatewayClientView,
          tileValueView: tileValueView,
          subscribedTopics: subscribedTopics,
        ),
      );

      /// trigger mqtt subscribed handle
      add(const MqttSubscribed());
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: TilesOverviewStatus.failure));
    }
  }

  String generateSubscribeTopicKey(Broker broker, MqttDevice device) {
    return '${broker.url}: ${broker.port}/${device.topic}';
  }

  /// mqtt topic publish handle
  Future<void> _onMqttSubscribed(
    MqttSubscribed event,
    Emitter<TilesOverviewState> emit,
  ) async {
    try {
      final gatewayClients = state.gatewayClients;
      await emit.forEach<List<String>>(
        repository.getPublishMsg(gatewayClients),
        onData: (msg) {
          final tileValueView = Map<FieldId, String?>.from(state.tileValueView);
          final subscribedTopics =
              Map<String, String>.from(state.subscribedTopics);
          // retrieve info from msg
          // format [brokerID, topic, payload]
          final brokerID = msg[0];
          final topic = msg[1];
          final payload = msg[2];

          // iter through list of tile info to update
          // using for with i counter to get index and better performance
          for (var i = 0; i < state.tileConfigs.length; i++) {
            // retrieve current list of tile info
            final tileConfig = state.tileConfigs[i];
            // retrieve matched mqtt device
            final device = state.mqttDeviceView[tileConfig.deviceID];
            if (device == null) {
              throw Exception('cant find device info');
            }
            // check whether brokerID and topic of message matched
            // with brokerID and topic of tile
            if (brokerID == device.brokerID && topic == device.topic) {
              // find corresponding broker
              final broker = state.brokerView[brokerID];
              if (broker == null) {
                throw Exception('can not find correspond broker');
              }
              final subscribedTopicKey = generateSubscribeTopicKey(
                broker,
                device,
              );
              // add payload as last message
              subscribedTopics[subscribedTopicKey] = payload;
              // filters payload by tile's type
              switch (tileConfig.tileType) {
                case TileType.toggle:
                  final toggleTileData = tileConfig.tileData as ToggleTileData;
                  final value = decodeJsonPayload(
                    jsonEnable: toggleTileData.jsonEnable,
                    jsonExtraction: toggleTileData.jsonExtraction,
                    payload: payload,
                  );
                  tileValueView[tileConfig.id] = value;
                  break;
                case TileType.text:
                  final textTileData = tileConfig.tileData as TextTileData;
                  final value = decodeJsonPayload(
                    jsonEnable: textTileData.jsonEnable,
                    jsonExtraction: textTileData.jsonExtraction,
                    payload: payload,
                  );
                  tileValueView[tileConfig.id] = value;
                  break;
              }
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
    final mqttDevice = state.mqttDeviceView[tileConfig.deviceID];
    // get gateway client of tile
    final gatewayClient = state.gatewayClientView[mqttDevice?.brokerID];
    if (gatewayClient == null || mqttDevice == null) {
      throw Exception('cant find gateway client');
    }
    gatewayClient.published(event.payload, mqttDevice.topic);
  }
}
