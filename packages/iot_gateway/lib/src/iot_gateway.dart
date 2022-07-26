import 'package:iot_api/iot_api.dart';
import 'package:iot_gateway/iot_gateway.dart';

/// {@template iot_gateway}
/// A MQTT gateway that handles MQTT client
/// {@endtemplate}
class IotGateway {
  /// {@macro iot_gateway}
  IotGateway();

  /// Creates [GatewayClient]
  GatewayClient createClient(Broker broker) {
    return GatewayClient(broker: broker);
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
