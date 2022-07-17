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
  Future<int> countProject() async {
    final response = await _httpClient.get(
      Uri.http(kBaseURL, '/api/project/countall/$_schema'),
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return body['count'] as int;
    }
    throw RequestFailureException();
  }

  @override
  Future<int> countDevice() async {
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
  Future<List<Device>> getNDevice({
    int startIndex = 0,
    int count = 10,
  }) async {
    final queryParameters = {'startOffset': '$startIndex', 'count': '$count'};
    final response = await _httpClient.get(
      Uri.http(kBaseURL, '/api/device/getndevice/$_schema', queryParameters),
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as List<dynamic>;
      final devices = body
          .map<Device>(
            (dynamic device) =>
                Device.fromJson(device as Map<String, dynamic>),
          )
          .toList();
      return devices;
    }
    throw RequestFailureException();
  }

  @override
  Future<List<Project>> getNProject({
    int startIndex = 0,
    int count = 10,
  }) async {
    final queryParameters = {'startOffset': '$startIndex', 'count': '$count'};
    final response = await _httpClient.get(
      Uri.http(kBaseURL, '/api/project/getnproject/$_schema', queryParameters),
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as List<dynamic>;
      final projects = body
          .map<Project>(
            (dynamic project) =>
                Project.fromJson(project as Map<String, dynamic>),
          )
          .toList();
      return projects;
    }
    throw RequestFailureException();
  }

  @override
  Future<List<Station>> getAllStationInProject({required int projectId}) async {
    final queryParameters = {'projectId': '$projectId'};
    final response = await _httpClient.get(
      Uri.http(kBaseURL, '/api/station/getallstationinproject/$_schema',
          queryParameters,),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as List<dynamic>;
      final stations = body
          .map<Station>(
            (dynamic station) =>
                Station.fromJson(station as Map<String, dynamic>),
          )
          .toList();
      return stations;
    }
    throw RequestFailureException();
  }

  @override
  Future<List<Device>> getAllDeviceInProject({required int projectId}) async {
    final queryParameters = {'projectId': '$projectId'};
    final response = await _httpClient.get(
      Uri.http(kBaseURL, '/api/device/getalldeviceinproject/$_schema',
          queryParameters,),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as List<dynamic>;
      final devices = body
          .map<Device>(
            (dynamic station) =>
                Device.fromJson(station as Map<String, dynamic>),
          )
          .toList();
      return devices;
    }
    throw RequestFailureException();
  }

  @override
  Future<List<Device>> getAllDeviceInStation({required int stationId}) async {
    final queryParameters = {'stationId': '$stationId'};
    final response = await _httpClient.get(
      Uri.http(kBaseURL, '/api/device/getalldeviceinstation/$_schema',
          queryParameters,),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as List<dynamic>;
      final devices = body
          .map<Device>(
            (dynamic station) =>
                Device.fromJson(station as Map<String, dynamic>),
          )
          .toList();
      return devices;
    }
    throw RequestFailureException();
  }

  ///
  double sin2(int dt) => sin(dt / 8 * 2 * pi);

  ///
  double sin3(int dt) => sin(dt / 12 * 2 * pi);

  ///
  double sin5(int dt) => sin(dt / 20 * 2 * pi);

  @override
  Stream<List<LiveData>> fetchLiveData() {
    return Stream.periodic(
      const Duration(seconds: 1),
      (dt) {
        final first = 20 + sin2(dt) - 2 * sin3(dt) + 4 * sin5(dt);
        final second = 24 + 2 * sin2(dt) + 3 * sin3(dt) - 3 * sin5(dt);
        final third = 18 + 3 * sin2(dt) - 2 * sin3(dt) - sin5(dt);
        final result = [
          LiveData(
            double.parse(first.toStringAsFixed(1)),
            DateTime(2022, 6, 29, 0, 31).add(Duration(minutes: dt)),
          ),
          LiveData(
            double.parse(second.toStringAsFixed(1)),
            DateTime(2022, 6, 29, 0, 31).add(Duration(minutes: dt)),
          ),
          LiveData(
            double.parse(third.toStringAsFixed(1)),
            DateTime(2022, 6, 29, 0, 31).add(Duration(minutes: dt)),
          ),
        ];
        return result;
      },
    );
  }
}
