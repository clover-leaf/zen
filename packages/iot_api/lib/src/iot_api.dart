import 'package:iot_api/iot_api.dart';

/// {@template iot_api}
/// The interface and models for an API providing access to IoT.
/// {@endtemplate}
abstract class IotApi {
  /// {@macro iot_api}
  const IotApi();

  /// Gets the [Broker]
  Broker getBroker();

  /// Get latest [List] of [Project]
  List<Project> refreshProject();

  /// Get latest [List] of [Device]
  List<Device> refreshDevice();
  
  /// Get latest [List] of [TileConfig]
  List<TileConfig> refreshTileConfig();

  /// Gets the [Stream] of [List] of [Project]
  Stream<List<Project>> getProjects();

  /// Gets the [Stream] of [List] of [Device]
  Stream<List<Device>> getDevices();

  /// Gets the [Stream] of [List] of [TileConfig]
  Stream<List<TileConfig>> getTileConfigs();

  /// If this [TileConfig] existed in db, updates it,
  /// else saves it
  Future<void> saveTileConfig(TileConfig tileConfig);

  /// If this [Device] existed in db, updates it,
  /// else saves it
  Future<void> saveDevice(Device device);
}

/// Error throw when request failure
class RequestFailureException implements Exception {}
