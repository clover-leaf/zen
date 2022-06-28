import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iot_api/iot_api.dart';
import 'package:meta/meta.dart';

/// {@template remote_storage_iot_api}
/// An implementation of IoT API that uses remote storage.
/// {@endtemplate}
class RemoteStorageIotApi extends IotApi {
  /// {@macro remote_storage_iot_api}
  const RemoteStorageIotApi({required http.Client httpClient})
      : _httpClient = httpClient;

  @visibleForTesting

  /// iOS emulator: 127.0.0.1 or localhost
  /// Android emulator: 10.0.2.2
  /// real device: 192.168.1.3 (host ip)
  static const String kBaseURL = '192.168.1.4:9876';

  /// schema name
  static const String schema = 'thang';
  final http.Client _httpClient;

  @override
  Future<List<Device>> fetchDevices({
    int startIndex = 0,
    int count = 5,
  }) async {
    final queryParameters = {'offset': '$startIndex', 'count': '$count'};

    final response = await _httpClient.get(
      Uri.http(kBaseURL, '/api/device/getndevice/$schema', queryParameters),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as List<dynamic>;
      final devices = body
          .map<Device>(
            (dynamic device) => Device.fromJson(device as Map<String, dynamic>),
          )
          .toList();
      return devices;
    }
    throw RequestFailureException();
  }

  @override
  Future<bool> deleteDevice(String id) async {
    final response = await _httpClient.put(
      Uri.http(kBaseURL, '/api/device/delete/$schema'),
      body: jsonEncode({
        'id': id,
      }),
    );

    if (response.statusCode == 200) {
      // final body = jsonDecode(response.body) as List<dynamic>;
    }
    throw RequestFailureException();
  }

  @override
  Future<bool> saveDevice(Device device) async {
    final response = await _httpClient.post(
      Uri.http(kBaseURL, '/api/device/create/$schema'),
      body: device.toJson(),
    );

    if (response.statusCode == 200) {
      // final body = jsonDecode(response.body) as List<dynamic>;
      // final devices = body.map<Device>(Device.fromJson).toList();
    }
    throw RequestFailureException();
  }

  @override
  Future<int> getNumberOfDevices() async {
    final response = await _httpClient.get(
      Uri.http(kBaseURL, '/api/device/countall/$schema'),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return body['count'] as  int;
    }
    throw RequestFailureException();
  }
}
