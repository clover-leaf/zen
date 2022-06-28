
import 'package:iot_api/iot_api.dart';

/// {@template iot_api}
/// The interface and models for an API providing access to IoT.
/// {@endtemplate}
abstract class IotApi {
  /// {@macro iot_api}
  const IotApi();
  
  /// Fetch list of [Device], 
  /// 
  /// Default start with first index = 0 and count = 20 devices
  Future<List<Device>> fetchDevices({int startIndex = 0, int count = 20});

  /// Delete a [Device] with given id
  /// 
  /// If no [Device] with given id exists, a [DeviceNotFoundException]
  /// is throw.
  Future<bool> deleteDevice(String id);

  /// Get number of devices in database
  /// 
  Future<int> getNumberOfDevices();

  /// Save a [Device]
  /// 
  /// If a [Device] with the same id already exists, it will be replaced.
  Future<bool> saveDevice(Device device);
}

/// Error throw when a [Device] with given id is not found.
class DeviceNotFoundException implements Exception {}

/// Error throw when request fail 
class RequestFailureException implements Exception {}
