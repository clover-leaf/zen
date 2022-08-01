import 'package:iot_gateway/iot_gateway.dart';

/// {@template iot_gateway}
/// A MQTT gateway that handles MQTT client
/// {@endtemplate}
class IotGateway {
  /// {@macro iot_gateway}
  IotGateway();

  ///
  static final json = {
    'url': 'io.adafruit.com',
    'port': 1883,
    'username': 'thangnguyen106',
    'password': 'aio_TanT84FMKkLpM2wYCrOIbOMUCwmW'
  };

  /// Creates [GatewayClient]
  GatewayClient createClient() {
    return GatewayClient(broker: Broker.fromJson(json));
  }

  /// Gets a [Stream] of published msg from given [GatewayClient]
  Stream<List<String>> getPublishMsg(GatewayClient client) {
    return client.getPublishMessages();
  }

  /// Gets a [Stream] of [ConnectionStatus] from given [GatewayClient]
  Stream<ConnectionStatus> getConnectionStatus(GatewayClient client) {
    return client.getConnectionStatus();
  }
}
