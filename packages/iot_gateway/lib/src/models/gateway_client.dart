import 'dart:convert';
import 'dart:developer';

import 'package:iot_api/iot_api.dart';
import 'package:iot_gateway/src/models/models.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';
import 'package:rxdart/subjects.dart';
import 'package:typed_data/typed_buffers.dart';
import 'package:uuid/uuid.dart';

/// {@template gateway_client}
/// The gateway client model that handles MQTT related requests.
/// {@endtemplate}
class GatewayClient {
  /// {@macro gateway_client}
  GatewayClient({
    required this.broker,
    String? clientID,
  })  : assert(
          clientID == null || clientID.isNotEmpty,
          'clientID can not be null and should be empty',
        ),
        _clientID = clientID ?? const Uuid().v4() {
    _client = MqttServerClient.withPort(broker.url, _clientID, broker.port)
      ..clientIdentifier = clientID ?? ''
      ..logging(on: false)
      ..keepAlivePeriod = 30
      ..onConnected = onConnected
      ..onDisconnected = onDisconnect
      ..onSubscribed = onSubscribe;

    final connMess = MqttConnectMessage().startClean();
    _client.connectionMessage = connMess;
  }

  /// The broker
  final Broker broker;

  /// The id of client
  final String _clientID;

  /// The Mqtt client instance
  late MqttServerClient _client;

  /// The controller of [Stream] of [ConnectionStatus]
  final _connectionStatusStreamController =
      BehaviorSubject<ConnectionStatus>.seeded(ConnectionStatus.disconnected);

  /// Connects to the broker
  Future<void> connect() async {
    _connectionStatusStreamController.add(ConnectionStatus.connecting);
    if (broker.username != '' && broker.password != '') {
      await _client.connect(
        broker.username,
        broker.password,
      );
    } else {
      await _client.connect();
    }
  }

  /// Disconnects to broker
  void disconnect() {
    _connectionStatusStreamController.add(ConnectionStatus.disconnecting);
    _client.disconnect();
  }

  /// Gets the [Stream] of [ConnectionStatus]
  Stream<ConnectionStatus> getConnectionStatus() =>
      _connectionStatusStreamController.asBroadcastStream();

  /// Subscribes to given topic
  void subscribe(String topic) {
    _client.subscribe(topic, MqttQos.atMostOnce);
    // because adafruit not have retain msg system
    // so we must publish topic/get to get retain msg
    if (broker.url == 'io.adafruit.com') {
      published('', '$topic/get', retain: false);
    }
  }

  /// Publishes message to given topic
  void published(String payload, String topic, {bool retain = true}) {
    final encoded = Uint8Buffer()..addAll(utf8.encode(payload));
    _client.publishMessage(
      topic,
      MqttQos.atLeastOnce,
      encoded,
      retain: retain,
    );
  }

  /// Get a stream of published messages of given topics
  Stream<List<String>> getPublishMessages() {
    return _client.published!.map((MqttPublishMessage message) {
      final topic = message.variableHeader!.topicName;
      final payload = utf8.decode(message.payload.message!.toList());
      return [topic, payload];
    });
  }

  /// Connection callback
  void onConnected() {
    log('::MQTT_CLIENT ${broker.title}:: Ket noi thanh cong...');
    _connectionStatusStreamController.add(ConnectionStatus.connected);
  }

  /// Subscribe callback
  void onSubscribe(MqttSubscription whatever) {
    log(
      '::MQTT_CLIENT ${broker.title}::'
      ' Subscribe thanh cong... ${whatever.topic}',
    );
  }

  /// Disconnect callback
  void onDisconnect() {
    log('::MQTT_CLIENT ${broker.title}:: Ngat ket noi...');
    _connectionStatusStreamController.add(ConnectionStatus.disconnected);
  }
}
