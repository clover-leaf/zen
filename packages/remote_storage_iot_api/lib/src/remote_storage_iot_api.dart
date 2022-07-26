import 'dart:convert';
import 'dart:io';

import 'package:iot_api/iot_api.dart';
import 'package:path/path.dart' as path;
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

  /// Reads file as [String]
  String readJsonFile(String relativePath) {
    final filePath = path.join(Directory.current.path, 'lib/src', relativePath);
    return File(filePath).readAsStringSync();
  }

  @override
  Broker getBroker() {
    final brokerJson = readJsonFile('broker.json');
    late List<Broker> brokers;
    try {
      // Parses brokers JSON file
      brokers = (jsonDecode(brokerJson) as List<dynamic>)
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
    final projectJson = readJsonFile('project.json');
    late List<Project> projects;
    try {
      // Parses projects JSON file
      projects = (jsonDecode(projectJson) as List<dynamic>)
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
    final deviceJson = readJsonFile('device.json');
    late List<Device> devices;
    try {
      // Parses devices JSON file
      devices = (jsonDecode(deviceJson) as List<dynamic>)
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
    final tileConfigJson = readJsonFile('tile_config.json');
    late List<TileConfig> tileConfigs;
    try {
      // Parses projects JSON file
      tileConfigs = (jsonDecode(tileConfigJson) as List<dynamic>)
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
}
