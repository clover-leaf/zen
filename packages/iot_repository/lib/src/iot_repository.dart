import 'package:iot_api/iot_api.dart';
import 'package:iot_gateway/iot_gateway.dart';

/// {@template iot_repository}
/// A repository that handles application needed requests.
/// {@endtemplate}
class IotRepository {
  /// {@macro iot_repository}
  const IotRepository({
    required IotApi api,
    required IotGateway gateway,
  })  : _api = api,
        _gateway = gateway;

  /// The Iot api that handles api requests
  final IotApi _api;

  /// The Iot gateway that handles MQTT related requests
  final IotGateway _gateway;

  /// Gets the only [Broker] of application
  Broker getBroker() => _api.getBroker();

  /// Get latest [List] of [Project]
  List<Project> refreshProject() => _api.refreshProject();

  /// Get latest [List] of [Device]
  List<Device> refreshDevice() => _api.refreshDevice();
  
  /// Get latest [List] of [TileConfig]
  List<TileConfig> refreshTileConfig() => _api.refreshTileConfig();

  /// Gets the [Stream] of [List] of [Project]
  Stream<List<Project>> getProjects() => _api.getProjects();

  /// Gets the [Stream] of [List] of [Device]
  Stream<List<Device>> getDevices() =>  _api.getDevices();

  /// Gets the [Stream] of [List] of [TileConfig]
  Stream<List<TileConfig>> getTileConfigs() => _api.getTileConfigs();

  /// If this [TileConfig] existed in db, updates it,
  /// else saves it
  Future<void> saveTileConfig(TileConfig tileConfig) {
    return _api.saveTileConfig(tileConfig);
  }

  /// If this [Device] existed in db, updates it,
  /// else saves it
  Future<void> saveDevice(Device device) {
    return _api.saveDevice(device);
  }

  /// gets a stream of data from [Broker]
  Stream<List<String>> getPublishMsg(GatewayClient client) {
    return _gateway.getPublishMsg(client);
  }

  /// creates [GatewayClient] with given [Broker]
  GatewayClient createClient(Broker broker) {
    return _gateway.createClient(broker);
  }
  
  /// Gets a [Stream] of [ConnectionStatus] from given [GatewayClient]
  Stream<ConnectionStatus> getConnectionStatus(GatewayClient client) {
    return client.getConnectionStatus();
  }
}
