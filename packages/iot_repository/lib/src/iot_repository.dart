import 'package:iot_api/iot_api.dart';
import 'package:iot_gateway/iot_gateway.dart';

/// {@template iot_repository}
/// A repository that handles iot related requests.
/// {@endtemplate}
class IotRepository {
  /// {@macro iot_repository}
  const IotRepository({
    required IotApi api,
    required IotGateway gateway,
  })  : _api = api,
        _gateway = gateway;

  /// IoT API
  final IotApi _api;

  /// IoT gateway
  final IotGateway _gateway;

  /// gets stream of brokers
  Stream<List<Broker>> getBrokers() {
    return _api.getBrokers();
  }

  /// gets stream of mqtt devices
  Stream<List<MqttDevice>> getMqttDevices() {
    return _api.getMqttDevices();
  }

  /// gets stream of tiule configs
  Stream<List<TileConfig>> getTileConfigs() {
    return _api.getTileConfigs();
  }

  /// if tile config exist in db, updates it
  /// else save it
  Future<void> saveTileConfig(TileConfig tileConfig) {
    return _api.saveTileConfig(tileConfig);
  }

  /// gets a stream of data from [Broker]
  Stream<List<String>> getPublishMsg(Iterable<GatewayClient> clients) {
      return _gateway.getPublishMsg(clients);
  }

  /// creates [GatewayClient] with given [Broker]
  GatewayClient createClient(Broker broker) {
      return _gateway.createClient(broker);
  }

  /// Get total number of [Project],
  ///
  Future<int> countProject() async {
    return _api.countProject();
  }

  /// Get total number of [Device],
  ///
  Future<int> countDevice() async {
    return _api.countDevice();
  }

  /// Get all [Device] in schema with given params,
  ///
  Future<List<Device>> getNDevice({
    int startIndex = 0,
    int count = 10,
  }) async {
    return _api.getNDevice(
      startIndex: startIndex,
      count: count,
    );
  }

  /// Get all [Project] in schema with given params,
  ///
  Future<List<Project>> getNProject({
    int startIndex = 0,
    int count = 10,
  }) async {
    return _api.getNProject(
      startIndex: startIndex,
      count: count,
    );
  }

  /// Get all [Station] of a [Project] that given id
  ///
  Future<List<Station>> getAllStationInProject({required int projectId}) async {
    return _api.getAllStationInProject(projectId: projectId);
  }

  /// Get all [Device] of a [Project] that given id
  ///
  Future<List<Device>> getAllDeviceInProject({required int projectId}) async {
    return _api.getAllDeviceInProject(projectId: projectId);
  }

  /// Get all [Device] of a [Station] that given id
  ///
  Future<List<Device>> getAllDeviceInStation({required int stationId}) async {
    return _api.getAllDeviceInStation(stationId: stationId);
  }

  /// return stream of data for dashboard
  Stream<List<LiveData>> fetchLiveData() {
    return _api.fetchLiveData();
  }

  /// Get all of [Message],
  ///
  Future<List<Message>> getAllMessage() async {
    final mockMessages = [
      Message(
        title: 'High CO2 level',
        createAt: DateTime(2022, 6, 13),
        isReaded: false,
        alertLevel: AlertLevel.high,
        description: 'description',
      ),
      Message(
        title: 'Lost connection',
        createAt: DateTime(2022, 6, 10),
        isReaded: false,
        alertLevel: AlertLevel.normal,
        description: 'description',
      ),
      Message(
        title: 'Lost connection',
        createAt: DateTime(2022, 6, 10),
        isReaded: true,
        alertLevel: AlertLevel.normal,
        description: 'description',
      ),
      Message(
        title: 'High CO2 level',
        createAt: DateTime(2022, 6, 10),
        isReaded: true,
        alertLevel: AlertLevel.high,
        description: 'description',
      ),
    ];
    return mockMessages;
  }
}
