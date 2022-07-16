import 'package:iot_api/iot_api.dart';

/// {@template iot_api}
/// The interface and models for an API providing access to IoT.
/// {@endtemplate}
abstract class IotApi {
  /// {@macro iot_api}
  const IotApi();

  /// Get total number of [Project],
  ///
  Future<int> countProject();

  /// Get all [Project] in schema with given params,
  ///
  Future<List<Project>> getNProject({int startIndex = 0, int count = 10});

  /// Get all [Station] of a [Project] that given id
  ///
  Future<List<Station>> getAllStationInProject({required int projectId});

  /// Get all [Device] of a [Project] that given id
  ///
  Future<List<Device>> getAllDeviceInProject({required int projectId});

  /// Get all [Device] of a [Station] that given id
  ///
  Future<List<Device>> getAllDeviceInStation({required int stationId});

  // /// Delete a [Device] with given id
  // ///
  // /// If no [Device] with given id exists, a [DeviceNotFoundException]
  // /// is throw.
  // Future<bool> deleteDevice(String id);

  // /// Save a [Device]
  // ///
  // /// If a [Device] with the same id already exists, it will be replaced.
  // Future<bool> saveDevice(Device device);

  /// Get stream list of data
  ///
  /// each return list of live datas
  Stream<List<LiveData>> fetchLiveData();
}

/// Error throw when a [Device] with given id is not found.
class DeviceNotFoundException implements Exception {}

/// Error throw when request fail
class RequestFailureException implements Exception {}
