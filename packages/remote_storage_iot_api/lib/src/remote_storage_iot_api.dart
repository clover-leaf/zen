
import 'package:iot_api/iot_api.dart';
import 'package:rxdart/subjects.dart';

/// {@template remote_storage_iot_api}
/// An implementation of IoT API that uses remote storage.
/// {@endtemplate}
class RemoteStorageIotApi extends IotApi {
  /// {@macro remote_storage_iot_api}
  RemoteStorageIotApi() {
    _init();
  }

  /// The controller of [Stream] of [List] of [Project]
  late BehaviorSubject<List<Project>> _projectStreamController;

  /// The controller of [Stream] of [List] of [Device]
  late BehaviorSubject<List<Device>> _deviceStreamController;

  /// The controller of [Stream] of [List] of [TileConfig]
  late BehaviorSubject<List<TileConfig>> _tileConfigStreamController;

  ///
  final brokerJson = [
    {
      'id': '63c59d69-0388-45f6-b0a3-a525e0afce38',
      'title': 'mosquitto',
      'url': '192.168.1.7',
      'port': 1883,
      'username': '',
      'password': ''
    },
    {
      'id': '047d3036-7523-4696-8131-0b2705e48116',
      'title': 'adafruit',
      'url': 'io.adafruit.com',
      'port': 1883,
      'username': 'relax1903',
      'password': 'aio_RGvj24BIcAAuBXEASkFU2F5NtzRt'
    }
  ];

  ///
  final projectsJson = [
    {
      'id': '99b2be2f-b082-483f-92b2-56585e6935b0',
      'title': 'My home',
      'brokerID': '63c59d69-0388-45f6-b0a3-a525e0afce38'
    },
    {
      'id': 'f81a8e53-a766-498d-9793-2b4b50109b25',
      'title': 'My farm',
      'brokerID': '63c59d69-0388-45f6-b0a3-a525e0afce38'
    }
  ];

  ///
  final devicesJson = [
    {
      'id': '6d034377-1bac-4c75-828f-b1999f87a05f',
      'projectID': '99b2be2f-b082-483f-92b2-56585e6935b0',
      'title': 'Home DHT-22 sensor',
      'topic': 'esp',
      'jsonEnable': true,
      'jsonVariables': [
        {
          'id': '681b7a7a-2a28-462d-ab77-564f44b35896',
          'deviceID': '6d034377-1bac-4c75-828f-b1999f87a05f',
          'title': 'temperature',
          'jsonExtraction': r"$['temp']"
        },
        {
          'id': '30364bf7-0be3-4d0d-add5-43c323b1fcdf',
          'deviceID': '6d034377-1bac-4c75-828f-b1999f87a05f',
          'title': 'himidity',
          'jsonExtraction': r"$['humid']"
        }
      ]
    },
    {
      'id': '354b7604-168b-492e-9f26-b12f6b3efbc4',
      'projectID': 'f81a8e53-a766-498d-9793-2b4b50109b25',
      'title': 'Farm DHT-22 sensor',
      'topic': 'esp',
      'jsonEnable': true,
      'jsonVariables': [
        {
          'id': '681b7a7a-2a28-462d-ab77-564f44b35896',
          'deviceID': '354b7604-168b-492e-9f26-b12f6b3efbc4',
          'title': 'temperature',
          'jsonExtraction': r"$['temp']"
        },
        {
          'id': '30364bf7-0be3-4d0d-add5-43c323b1fcdf',
          'deviceID': '354b7604-168b-492e-9f26-b12f6b3efbc4',
          'title': 'himidity',
          'jsonExtraction': r"$['humid']"
        }
      ]
    },
    // {
    //   'id': '6d034377-1bac-4c75-828f-b1999f87a05f',
    //   'projectID': '99b2be2f-b082-483f-92b2-56585e6935b0',
    //   'title': 'DHT-22 sensor',
    //   'topic': 'esp',
    //   'jsonEnable': false,
    //   'jsonVariables': <JsonVariable>[],
    // }
  ];

  ///
  final tileConfigsJson = [
    {
      'id': '3b49cf6b-fd4e-4cb0-84e3-c800fa42a6e2',
      'title': 'Kitchen temperature',
      'deviceID': '6d034377-1bac-4c75-828f-b1999f87a05f',
      'tileType': 1,
      'tileData': {
        'type': 1,
        'prefix': '',
        'postfix': '℃',
        'jsonVariableID': '681b7a7a-2a28-462d-ab77-564f44b35896'
      }
    },
    {
      'id': '6d034377-1bac-7777-828f-b1999f87a05f',
      'title': 'Kitchen humidity',
      'deviceID': '354b7604-168b-492e-9f26-b12f6b3efbc4',
      'tileType': 1,
      'tileData': {
        'type': 1,
        'prefix': '',
        'postfix': '%',
        'jsonVariableID': '30364bf7-0be3-4d0d-add5-43c323b1fcdf'
      }
    },
    // {
    //   'id': '3b49cf6b-fd4e-4cb0-84e3-c800fa42a6e2',
    //   'title': 'Kitchen temperature',
    //   'deviceID': '6d034377-1bac-4c75-828f-b1999f87a05f',
    //   'tileType': 0,
    //   'tileData': {
    //     'type': 0,
    //     'onLabel': 'ON',
    //     'onValue': '1',
    //     'offLabel': 'OFF',
    //     'offValue': '0',
    //     'jsonVariableID': '',
    //   }
    // }
  ];

  @override
  Broker getBroker() {
    late List<Broker> brokers;
    try {
      brokers = brokerJson
          .map<Broker>(
            (dynamic e) => Broker.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw Exception('can not parse JSON file');
    }
    return brokers[0];
  }

  @override
  List<Project> refreshProject() {
    late List<Project> projects;
    try {
      projects = projectsJson
          .map<Project>(
            (dynamic e) => Project.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw Exception('can not parse JSON file');
    }
    return projects;
  }

  @override
  List<Device> refreshDevice() {
    late List<Device> devices;
    try {
      devices = devicesJson
          .map<Device>(
            (dynamic e) => Device.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw Exception('can not parse JSON file');
    }
    return devices;
  }

  @override
  List<TileConfig> refreshTileConfig() {
    late List<TileConfig> tileConfigs;
    try {
      tileConfigs = tileConfigsJson
          .map<TileConfig>(
            (dynamic e) => TileConfig.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw Exception('can not parse JSON file');
    }
    return tileConfigs;
  }

  /// Initializes [Stream]
  void _init() {
    final projects = refreshProject();
    final devices = refreshDevice();
    final tileConfigs = refreshTileConfig();

    // Initialized project stream
    _projectStreamController = BehaviorSubject<List<Project>>.seeded(projects);

    // Initialized device stream
    _deviceStreamController = BehaviorSubject<List<Device>>.seeded(devices);

    // initialized tile config stream
    _tileConfigStreamController =
        BehaviorSubject<List<TileConfig>>.seeded(tileConfigs);
  }

  @override
  Stream<List<Project>> getProjects() =>
      _projectStreamController.asBroadcastStream();

  @override
  Stream<List<Device>> getDevices() =>
      _deviceStreamController.asBroadcastStream();

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
  Future<void> saveDevice(Device device) async {
    final devices = [..._deviceStreamController.value];
    final idx = devices.indexWhere((t) => t.id == device.id);
    if (idx >= 0) {
      devices[idx] = device;
    } else {
      devices.add(device);
    }
    _deviceStreamController.add(devices);
  }
}
