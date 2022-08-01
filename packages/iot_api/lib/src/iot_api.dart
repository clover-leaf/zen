import 'package:iot_api/iot_api.dart';

/// {@template iot_api}
/// The interface and models for an API providing access to IoT.
/// {@endtemplate}
abstract class IotApi {
  /// {@macro iot_api}
  const IotApi();

  /// Refresh all [Project] and [Device]
  Future<void> refresh();

  /// Get latest [List] of [Project]
  Future<List<Project>> fetchProjects();

  /// Get latest [List] of [Device]
  Future<List<Device>> fetchDevices();

  /// Get latest [List] of [TileConfig]
  Future<List<TileConfig>> fetchTileConfigs();

  /// Gets the [Stream] of [List] of [Project]
  Stream<List<Project>> getProjects();

  /// Gets the [Stream] of [List] of [Device]
  Stream<List<Device>> getDevices();

  /// Gets the [Stream] of [List] of [TileConfig]
  Stream<List<TileConfig>> getTileConfigs();

  /// Saves [TileConfig]
  Future<void> saveTileConfig(TileConfig tileConfig);

  /// Updates [TileConfig]
  Future<void> updateTileConfig(TileConfig tileConfig);

  /// If this [TileConfig] existed in db, deletes it
  Future<void> deleteTileConfig(TileConfig tileConfig);

  /// Saves [Device]
  Future<void> saveDevice(Device device, String projectKey);

  /// Updates [Device]
  Future<void> updateDevice(Device device, String projectKey, String oldKey);

  /// If this [Device] existed in db, deletes it
  Future<void> deleteDevice(Device device);

  /// Saves new [Project]
  Future<void> saveProject(Project project);

  /// Updates new [Project]
  Future<void> updateProject(Project project, String oldKey);

  /// If this [Project] existed in db, deletes it
  Future<void> deleteProject(Project project);
}

/// Error throw when request failure
class RequestFailureException implements Exception {}
