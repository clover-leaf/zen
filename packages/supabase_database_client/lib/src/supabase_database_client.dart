import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iot_api/iot_api.dart';
import 'package:rxdart/subjects.dart';
import 'package:supabase_database_client/src/models/supabase_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// {@template supabase_database_exception}
/// A generic supabase database exception.
/// {@endtemplate}
abstract class SupabaseDatabaseException implements Exception {
  /// {@macro supabase_database_exception}
  const SupabaseDatabaseException(this.error);

  /// The error which was caught.
  final Object error;
}

/// {@template supabase_user_information_failure}
/// Thrown during the get user information process if a failure occurs.
/// {@endtemplate}
class SupabaseUserInformationFailure extends SupabaseDatabaseException {
  /// {@macro supabase_user_information_failure}
  const SupabaseUserInformationFailure(super.error);
}

/// {@template supabase_update_user_failure}
/// Thrown during the update user information process if a failure occurs.
/// {@endtemplate}
class SupabaseUpdateUserFailure extends SupabaseDatabaseException {
  /// {@macro supabase_update_user_failure}
  const SupabaseUpdateUserFailure(super.error);
}

/// {@template supabase_database_client}
/// Supabase database client
/// {@endtemplate}
class SupabaseDatabaseClient extends IotApi {
  /// {@macro supabase_database_client}
  SupabaseDatabaseClient({
    required SupabaseClient supabaseClient,
    required http.Client httpClient,
  })  : _supabaseClient = supabaseClient,
        _httpClient = httpClient;

  /// The Adafruit.io url
  static const String kBaseURL = 'supademo1903.herokuapp.com';

  /// The http client object
  final http.Client _httpClient;

  final SupabaseClient _supabaseClient;

  /// The controller of [Stream] of [List] of [Project]
  final _projectStreamController = BehaviorSubject<List<Project>>.seeded([]);

  /// The controller of [Stream] of [List] of [Device]
  final _deviceStreamController = BehaviorSubject<List<Device>>.seeded([]);

  /// The controller of [Stream] of [List] of [TileConfig]
  final _tileConfigStreamController =
      BehaviorSubject<List<TileConfig>>.seeded([]);

  @override
  Future<List<Project>> fetchProjects() async {
    final response = await _httpClient.get(
      Uri.http(kBaseURL, '/api/projects'),
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final data = body['data'] as List<dynamic>;
      final projects = data
          .map<Project>(
            (dynamic json) => Project.fromJson(json as Map<String, dynamic>),
          )
          .toList();
      return projects;
    } else {
      throw Exception('can not parse json');
    }
  }

  @override
  Future<void> updateProject(Project project, String oldKey) async {
    final projects = [..._projectStreamController.value];
    final idx = projects.indexWhere((t) => t.id == project.id);
    if (idx >= 0) {
      final body = project.toJson();
      body['user_id'] = _supabaseClient.auth.currentUser!.id;
      final response = await _httpClient.put(
        Uri.http(kBaseURL, '/api/projects/$oldKey'),
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        final data = body['data'] as Map<String, dynamic>;
        final updatedProject = Project.fromJson(data);
        projects[idx] = updatedProject;
        _projectStreamController.add(projects);
      } else {
        throw Exception('can not parse json');
      }
    }
  }

  @override
  Future<void> saveProject(Project project) async {
    final projects = [..._projectStreamController.value];
    final idx = projects.indexWhere((t) => t.id == project.id);
    if (idx == -1) {
      final body = project.toJson();
      body['user_id'] = _supabaseClient.auth.currentUser!.id;
      final response = await _httpClient.post(
        Uri.http(kBaseURL, '/api/projects'),
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        final data = body['data'] as Map<String, dynamic>;
        final newProject = Project.fromJson(data);
        projects.add(newProject);
        _projectStreamController.add(projects);
      } else {
        throw Exception('can not parse json');
      }
    }
  }

  // TODO(me): implement
  @override
  Future<void> deleteProject(Project project) async {
    final projects = [..._projectStreamController.value];
    final idx = projects.indexWhere((t) => t.id == project.id);
    if (idx >= 0) {
      projects.removeAt(idx);
    }
    _projectStreamController.add(projects);
  }

  @override
  Future<List<Device>> fetchDevices() async {
    final devices = <Device>[];
    final response = await _httpClient.get(Uri.http(kBaseURL, '/api/devices'));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final data = body['data'] as List<dynamic>;
      final _devices = data
          .map<Device>(
            (dynamic json) => Device.fromJson(json as Map<String, dynamic>),
          )
          .toList();
      devices.addAll(_devices);
    } else {
      throw Exception('can not parse json');
    }
    return devices;
  }

  @override
  Future<void> saveDevice(Device device, String projectKey) async {
    final devices = [..._deviceStreamController.value];
    final idx = devices.indexWhere((t) => t.id == device.id);
    if (idx == -1) {
      final body = device.toJson();
      body['project_key'] = projectKey;
      body['user_id'] = _supabaseClient.auth.currentUser!.id;
      final response = await _httpClient.post(
        Uri.http(kBaseURL, '/api/devices'),
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        final data = body['data'] as Map<String, dynamic>;
        final createdDevice = Device.fromJson(data);
        devices.add(createdDevice);
        _deviceStreamController.add(devices);
      } else {
        throw Exception('can not parse json');
      }
    }
  }

  @override
  Future<void> updateDevice(
    Device device,
    String projectKey,
    String oldKey,
  ) async {
    final devices = [..._deviceStreamController.value];
    final idx = devices.indexWhere((t) => t.id == device.id);
    if (idx >= 0) {
      final body = device.toJson();
      body['project_key'] = projectKey;
      body['user_id'] = _supabaseClient.auth.currentUser!.id;
      if (device.description != null) {
        body['description'] = device.description;
      }
      final response = await _httpClient.put(
        Uri.http(kBaseURL, '/api/devices/$oldKey'),
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        final data = body['data'] as Map<String, dynamic>;
        final updatedDevice = Device.fromJson(data);
        devices[idx] = updatedDevice;
        _deviceStreamController.add(devices);
      } else {
        throw Exception('can not parse json');
      }
    }
  }

  // TODO(me): implement
  @override
  Future<void> deleteDevice(Device device) async {
    final devices = [..._deviceStreamController.value];
    final idx = devices.indexWhere((t) => t.id == device.id);
    if (idx >= 0) {
      devices.removeAt(idx);
      _deviceStreamController.add(devices);
    }
    _deviceStreamController.add(devices);
  }

  @override
  Future<List<TileConfig>> fetchTileConfigs() async {
    final tileConfigs = <TileConfig>[];
    final response =
        await _httpClient.get(Uri.http(kBaseURL, '/api/tile-configs'));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final data = body['data'] as List<dynamic>;
      final _tileConfigs = data
          .map<TileConfig>(
            (dynamic json) => TileConfig.fromJson(json as Map<String, dynamic>),
          )
          .toList();
      tileConfigs.addAll(_tileConfigs);
    } else {
      throw Exception('can not parse json');
    }
    return tileConfigs;
  }

  @override
  Future<void> saveTileConfig(TileConfig tileConfig) async {
    final tileConfigs = [..._tileConfigStreamController.value];
    final idx = tileConfigs.indexWhere((t) => t.id == tileConfig.id);
    if (idx == -1) {
      final body = tileConfig.toJson();
      final response = await _httpClient.post(
        Uri.http(kBaseURL, '/api/tile-configs'),
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        final data = body['data'] as Map<String, dynamic>;
        final createdTieConfig = TileConfig.fromJson(data);
        tileConfigs.add(createdTieConfig);
        _tileConfigStreamController.add(tileConfigs);
      } else {
        throw Exception('can not parse json');
      }
    }
  }

  @override
  Future<void> updateTileConfig(TileConfig tileConfig) async {
    final tileConfigs = [..._tileConfigStreamController.value];
    final idx = tileConfigs.indexWhere((t) => t.id == tileConfig.id);
    if (idx >= 0) {
      final body = tileConfig.toJson();
      final response = await _httpClient.put(
        Uri.http(kBaseURL, '/api/tile-configs'),
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        final data = body['data'] as Map<String, dynamic>;
        final createdTieConfig = TileConfig.fromJson(data);
        tileConfigs.add(createdTieConfig);
        _tileConfigStreamController.add(tileConfigs);
      } else {
        throw Exception('can not parse json');
      }
    }
  }

  @override
  Future<void> deleteTileConfig(TileConfig tileConfig) async {
    final tileConfigs = [..._tileConfigStreamController.value];
    final idx = tileConfigs.indexWhere((t) => t.id == tileConfig.id);
    if (idx >= 0) {
      final response = await _httpClient.delete(
        Uri.http(kBaseURL, '/api/tile-configs'),
        body: jsonEncode({'id': tileConfig.id}),
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        final success = body['success'] as bool;
        if (success) {
          tileConfigs.removeAt(idx);
          _tileConfigStreamController.add(tileConfigs);
        } else {
          throw Exception('can not parse json');
        }
      } else {
        throw Exception('can not parse json');
      }
    }
  }

  @override
  Future<void> refresh() async {
    final projects = await fetchProjects();
    _projectStreamController.add(projects);

    final devices = await fetchDevices();
    _deviceStreamController.add(devices);

    final tilesConfigs = await fetchTileConfigs();
    _tileConfigStreamController.add(tilesConfigs);
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

  /// Method to get the user information by id
  /// from the profiles database on Supabase.
  Future<SupabaseUser> getUserProfile() async {
    try {
      final response = await _supabaseClient
          .from('account')
          .select()
          .eq('id', _supabaseClient.auth.currentUser?.id)
          .single()
          .execute();

      final data = response.data as Map<String, dynamic>;
      return SupabaseUser.fromJson(data);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        SupabaseUserInformationFailure(error),
        stackTrace,
      );
    }
  }

  /// Method to update the user information on the profiles database.
  Future<void> updateUser({required SupabaseUser user}) async {
    try {
      final supabaseUser = SupabaseUser(
        id: _supabaseClient.auth.currentUser?.id,
        userName: user.userName,
        companyName: user.companyName,
      );

      await _supabaseClient
          .from('account')
          .upsert(supabaseUser.toJson())
          .execute();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        SupabaseUpdateUserFailure(error),
        stackTrace,
      );
    }
  }
}
