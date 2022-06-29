import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:iot_api/iot_api.dart';
import 'package:meta/meta.dart';

/// {@template remote_storage_iot_api}
/// An implementation of IoT API that uses remote storage.
/// {@endtemplate}
class RemoteStorageIotApi extends IotApi {
  /// {@macro remote_storage_iot_api}
  RemoteStorageIotApi({
    required http.Client httpClient,
    required String schema,
  })  : _httpClient = httpClient,
        _schema = schema;

  @visibleForTesting

  /// iOS emulator: 127.0.0.1 or localhost
  /// Android emulator: 10.0.2.2
  /// real device: 192.168.1.3 (host ip)
  static const String kBaseURL = '192.168.1.4:9876';

  /// schema name
  final String _schema;

  /// http client object
  final http.Client _httpClient;

  @override
  Future<List<Device>> fetchDevices({
    int startIndex = 0,
    int count = 5,
  }) async {
    final queryParameters = {'startOffset': '$startIndex', 'count': '$count'};

    final response = await _httpClient.get(
      Uri.http(kBaseURL, '/api/device/getndevice/$_schema', queryParameters),
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
      Uri.http(kBaseURL, '/api/device/delete/$_schema'),
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
      Uri.http(kBaseURL, '/api/device/create/$_schema'),
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
      Uri.http(kBaseURL, '/api/device/countall/$_schema'),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return body['count'] as int;
    }
    throw RequestFailureException();
  }

  @override
  Stream<List<double>> fetchLiveData() {
    return Stream.periodic(
      const Duration(seconds: 1),
      (_) {
        final randomValues = List.generate(2, (index) {
          var nextRandom = 35 + Random().nextDouble() * 20 - 10;
          while (nextRandom > 45 || nextRandom < 0) {
            nextRandom = 35 + Random().nextDouble() * 20 - 10;
          }
          return double.parse(nextRandom.toStringAsFixed(1));
        });
        return randomValues;
      },
    );
  }
}
