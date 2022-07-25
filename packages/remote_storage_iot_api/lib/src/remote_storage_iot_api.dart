import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:iot_api/iot_api.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';

/// {@template remote_storage_iot_api}
/// An implementation of IoT API that uses remote storage.
/// {@endtemplate}
class RemoteStorageIotApi extends IotApi {
  /// {@macro remote_storage_iot_api}
  RemoteStorageIotApi({
    required http.Client httpClient,
    required String schema,
  })  : _httpClient = httpClient,
        _schema = schema {
    _init();
  }

  @visibleForTesting

  /// iOS emulator: 127.0.0.1 or localhost
  /// Android emulator: 10.0.2.2
  /// real device: 192.168.1.3 (host ip)
  static const String kBaseURL = '192.168.1.4:9876';

  final _brokerStreamController =
      BehaviorSubject<List<Broker>>.seeded(const []);
  final _mqttDeviceStreamController =
      BehaviorSubject<List<MqttDevice>>.seeded(const []);
  final _tileConfigStreamController =
      BehaviorSubject<List<TileConfig>>.seeded(const []);

  /// schema name
  final String _schema;

  /// http client object
  final http.Client _httpClient;

  ///
  final brokerJson = <dynamic>[
    {
      'title': 'My house',
      'url': '192.168.1.7',
      'port': 8883,
      'id': '63c59d69-0388-45f6-b0a3-a525e0afce38',
      'username': 'vv',
      'password': '1006',
    },
    {
      'title': 'adafruit',
      'url': 'io.adafruit.com',
      'port': 1883,
      'id': '047d3036-7523-4696-8131-0b2705e48116',
      'username': 'relax1903',
      'password': 'aio_pzus18hbCeHhAGgReod0sLvNnX2A',
    },
  ];

  ///
  final mqttDeviceJson = <dynamic>[
    {
      'id': '4f73ea4b-f825-401b-8a1c-ae3532c588ac',
      'brokerID': '63c59d69-0388-45f6-b0a3-a525e0afce38',
      'topic': 'esp',
      'title': 'Dht22 sensor',
    },
    {
      'id': '72f2d46f-a606-4694-86a5-0ff44227082c',
      'brokerID': '047d3036-7523-4696-8131-0b2705e48116',
      'topic': 'relax1903/feeds/sensors',
      'title': 'Adafruit sensor',
    },
  ];

  ///
  final tileConfigJson = <dynamic>[
    {
      'id': '3b49cf6b-fd4e-4cb0-84e3-c800fa42a6e2',
      'title': 'Room temperature',
      'deviceID': '4f73ea4b-f825-401b-8a1c-ae3532c588ac',
      'tileType': 'text',
      'tileData': {
        'type': 'text',
        'prefix': '',
        'postfix': '℃',
        'jsonEnable': true,
        'jsonExtraction': r'$["temp"]',
      },
    },
    {
      'id': '04dcc5cc-ac3b-4562-9aa3-5f47404fecdb',
      'title': 'Adafruit sensor',
      'deviceID': '72f2d46f-a606-4694-86a5-0ff44227082c',
      'tileType': 'toggle',
      'tileData': {
        'type': 'toggle',
        'onLabel': 'ON',
        'onValue': '1',
        'offLabel': 'OFF',
        'offValue': '0',
        'jsonEnable': false,
        'jsonExtraction': r'$["key"]',
      },
    },
  ];

  /// initialized
  void _init() {
    // initialized broker stream
    final brokers = brokerJson
        .map<Broker>(
          (dynamic json) => Broker.fromJson(json as Map<String, dynamic>),
        )
        .toList();
    _brokerStreamController.add(brokers);

    // initialized mqtt device stream
    final mqttDevices = mqttDeviceJson
        .map<MqttDevice>(
          (dynamic json) => MqttDevice.fromJson(json as Map<String, dynamic>),
        )
        .toList();
    _mqttDeviceStreamController.add(mqttDevices);

    // initialized tile config stream
    final tileConfigs = tileConfigJson
        .map<TileConfig>(
          (dynamic json) => TileConfig.fromJson(json as Map<String, dynamic>),
        )
        .toList();
    _tileConfigStreamController.add(tileConfigs);
  }

  @override
  Stream<List<Broker>> getBrokers() =>
      _brokerStreamController.asBroadcastStream();

  @override
  Stream<List<MqttDevice>> getMqttDevices() =>
      _mqttDeviceStreamController.asBroadcastStream();

  @override
  Stream<List<TileConfig>> getTileConfigs() =>
      _tileConfigStreamController.asBroadcastStream();

  @override
  Future<void> saveTileConfig(TileConfig tileConfig) async {
    final tileConfigs = [..._tileConfigStreamController.value];
    final idx = tileConfigs.indexWhere((t) => t.id == tileConfig.id);
    if (idx >= 0) {
      tileConfigs[idx] = tileConfig;
    } else {
      tileConfigs.add(tileConfig);
    }
    _tileConfigStreamController.add(tileConfigs);
  }

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
            (dynamic device) => Device.fromJson(device as Map<String, dynamic>),
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
      Uri.http(
        kBaseURL,
        '/api/station/getallstationinproject/$_schema',
        queryParameters,
      ),
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
      Uri.http(
        kBaseURL,
        '/api/device/getalldeviceinproject/$_schema',
        queryParameters,
      ),
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
      Uri.http(
        kBaseURL,
        '/api/device/getalldeviceinstation/$_schema',
        queryParameters,
      ),
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
