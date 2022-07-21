import 'package:async/async.dart' show StreamGroup;
import 'package:iot_api/iot_api.dart';
import 'package:iot_gateway/iot_gateway.dart';

/// {@template iot_gateway}
/// An Mqtt gateway that handles interaction with broker
/// {@endtemplate}
class IotGateway {
  /// {@macro iot_gateway}
  IotGateway();

  /// creates gateway client
  GatewayClient createClient(Broker broker) {
    return GatewayClient(broker: broker);
  }

  /// get a stream of published msg from given gateway client
  Stream<List<String>> getPublishMsg(Iterable<GatewayClient> clients) {
    return StreamGroup.merge(
      clients.map((client) => client.getPublishMessages()),
    );
  }
}
