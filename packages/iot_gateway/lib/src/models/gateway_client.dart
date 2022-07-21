import 'dart:convert';
import 'dart:developer';

import 'package:iot_api/iot_api.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:uuid/uuid.dart';

///
class GatewayClient {
  ///
  GatewayClient({
    required this.broker,
    String? clientID,
  })  : assert(
          clientID == null || clientID.isNotEmpty,
          'clientID can not be null and should be empty',
        ),
        _clientID = clientID ?? const Uuid().v4() {
    _client = MqttServerClient.withPort(broker.url, _clientID, broker.port)
      ..setProtocolV311()
      ..logging(on: false)
      ..keepAlivePeriod = 30
      ..onConnected = onConnected
      ..onDisconnected = onDisconnect
      ..onSubscribed = onSubscribe;

    final connMess = MqttConnectMessage()
        .withClientIdentifier(_clientID)

        /// no need to set will message
        /// because we dont need save status of app
        /// only need in device
        /// btw, in adafruit, all msg saved in db
        .withWillTopic('topic/active')
        .withWillMessage('Oops!')
        .withWillRetain()
        .withWillQos(MqttQos.atMostOnce);
    _client.connectionMessage = connMess;
  }

  /// The broker
  final Broker broker;

  /// client ID
  final String _clientID;

  /// mqtt client instance
  late MqttServerClient _client;

  /// logins into adafruit-IO
  Future<void> login() async {
    await _client.connect(
      broker.username,
      broker.password,
    );
  }

  /// subscribes to given topic
  void subscribe(String topic) {
    _client.subscribe(topic, MqttQos.atMostOnce);
  }

  /// publishes message to given top
  void published(String payload, String topic, {bool retain = true}) {
    final builder = MqttClientPayloadBuilder()..addString(payload);
    _client.publishMessage(
      topic,
      MqttQos.atMostOnce,
      builder.payload!,
      retain: retain,
    );
  }

  /// get a stream of published messages of given topics
  Stream<List<String>> getPublishMessages() {
    return _client.published!.map((MqttPublishMessage message) {
      final topic = message.variableHeader!.topicName;
      final payload = utf8.decode(message.payload.message);
      return [broker.id, topic, payload];
    });
  }

  ///
  void onConnected() {
    log('::MQTT_CLIENT ${broker.title}:: Ket noi thanh cong...');
  }

  ///
  void onSubscribe(String whatever) {
    log('::MQTT_CLIENT ${broker.title}:: Subscribe thanh cong... $whatever');
  }

  ///
  void onDisconnect() {
    log('::MQTT_CLIENT ${broker.title}:: Ngat ket noi...');
  }
}
