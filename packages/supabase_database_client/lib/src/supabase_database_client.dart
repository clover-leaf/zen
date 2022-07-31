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
  static const String kBaseURL = 'io.adafruit.com';

  /// The Adafruit.io url
  static const String ioKey = 'aio_pqbx54X7PwrJfbqb5ndRDWEDxikz';

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
      Uri.http(kBaseURL, '/api/v2/relax1903/groups'),
      headers: {
        'X-AIO-Key': ioKey,
      },
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as List<dynamic>;
      final projects = body.map<Project>((dynamic json) {
        final _json = json as Map<String, dynamic>;
        final key = _json['key'] as String;
        final name = _json['name'] as String;
        final description = _json['description'] as String?;
        final updatedAt = _json['updated_at'] as String;
        final createdAt = _json['created_at'] as String;
        return Project(
          key: key,
          name: name,
          description: description,
          createdAt: DateTime.parse(createdAt),
          updatedAt: DateTime.parse(updatedAt),
        );
      }).toList();
      final noneDefaults =
          projects.where((project) => project.key != 'default').toList();
      return noneDefaults;
    } else {
      throw Exception('can not parse json');
    }
  }

  @override
  Future<void> updateProject(Project project, String oldKey) async {
    final projects = [..._projectStreamController.value];
    final idx = projects.indexWhere((t) => t.id == project.id);
    if (idx >= 0) {
      final body = {
        'key': project.key,
        'name': project.name,
      };
      if (project.description != null) {
        body['description'] = project.description!;
      }
      final response = await _httpClient.put(
        Uri.http(kBaseURL, '/api/v2/relax1903/groups/$oldKey'),
        body: body,
        headers: {
          'X-AIO-Key': ioKey,
        },
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        final updatedAt = body['updated_at'] as String;
        final createdAt = body['created_at'] as String;
        final description = body['description'] as String?;
        final name = body['name'] as String;
        final key = body['key'] as String;
        final updatedProject = project.copyWith(
          name: name,
          key: key,
          description: description,
          createdAt: DateTime.parse(createdAt),
          updatedAt: DateTime.parse(updatedAt),
        );
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
      final response = await _httpClient.post(
        Uri.http(kBaseURL, '/api/v2/relax1903/groups'),
        body: {
          'name': project.name,
          'key': project.key,
        },
        headers: {
          'X-AIO-Key': ioKey,
        },
      );
      if (response.statusCode == 201) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        final createdAt = body['created_at'] as String;
        final updatedAt = body['updated_at'] as String;
        final createdProject = project.copyWith(
          createdAt: DateTime.parse(createdAt),
          updatedAt: DateTime.parse(updatedAt),
        );
        projects.add(createdProject);
        _projectStreamController.add(projects);
      } else {
        throw Exception('can not parse json');
      }
    }
  }

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
  Future<List<Device>> fetchDevices(List<Project> projects) async {
    final devices = <Device>[];
    for (final project in projects) {
      final response = await _httpClient.get(
        Uri.http(kBaseURL, '/api/v2/relax1903/groups/${project.key}/feeds'),
        headers: {
          'X-AIO-Key': ioKey,
        },
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as List<dynamic>;
        final _devices = body.map<Device>((dynamic json) {
          final _json = json as Map<String, dynamic>;
          final _key = _json['key'] as String;
          final key = _key.split('.').last;
          final name = _json['name'] as String;
          final description = _json['description'] as String?;
          final updatedAt = _json['updated_at'] as String;
          final createdAt = _json['created_at'] as String;
          return Device(
            projectID: project.id,
            key: key,
            name: name,
            description: description,
            jsonEnable: false,
            jsonVariables: const [],
            createdAt: DateTime.parse(createdAt),
            updatedAt: DateTime.parse(updatedAt),
          );
        }).toList();
        devices.addAll(_devices);
      } else {
        throw Exception('can not parse json');
      }
    }
    return devices;
  }

  @override
  Future<void> saveDevice(Device device, String projectKey) async {
    final devices = [..._deviceStreamController.value];
    final idx = devices.indexWhere((t) => t.id == device.id);
    if (idx == -1) {
      final response = await _httpClient.post(
        Uri.http(kBaseURL, '/api/v2/relax1903/groups/$projectKey/feeds'),
        body: jsonEncode({
          'feed': {
            'name': device.name,
            'description': device.description,
            'key': device.key,
          }
        }),
        headers: {
          'Content-Type': 'application/json',
          'X-AIO-Key': ioKey,
        },
      );
      if (response.statusCode == 201) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        final createdAt = body['created_at'] as String;
        final updatedAt = body['updated_at'] as String;
        final createdDevice = device.copyWith(
          createdAt: DateTime.parse(createdAt),
          updatedAt: DateTime.parse(updatedAt),
        );
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
      final body = {
        'key': device.key,
        'name': device.name,
      };
      if (device.description != null) {
        body['description'] = device.description!;
      }
      final response = await _httpClient.put(
        Uri.http(kBaseURL, '/api/v2/relax1903/feeds/$projectKey.$oldKey'),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'X-AIO-Key': ioKey,
        },
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        final updatedAt = body['updated_at'] as String;
        final createdAt = body['created_at'] as String;
        final description = body['description'] as String?;
        final name = body['name'] as String;
        final updatedDevice = device.copyWith(
          name: name,
          description: description ?? device.description,
          createdAt: DateTime.parse(createdAt),
          updatedAt: DateTime.parse(updatedAt),
        );
        devices[idx] = updatedDevice;
        _deviceStreamController.add(devices);
      } else {
        throw Exception('can not parse json');
      }
    }
  }

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
    return [];
  }

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
  Future<void> deleteTileConfig(TileConfig tileConfig) async {
    final tileConfigs = [..._tileConfigStreamController.value];
    final idx = tileConfigs.indexWhere((t) => t.id == tileConfig.id);
    if (idx >= 0) {
      tileConfigs.removeAt(idx);
    }
    _tileConfigStreamController.add(tileConfigs);
  }

  @override
  Future<void> refresh() async {
    final projects = await fetchProjects();
    _projectStreamController.add(projects);

    final devices = await fetchDevices(projects);
    _deviceStreamController.add(devices);
  }

  @override
  Future<void> initialized() async {
    await refresh();

    // final tileConfigs = await fetchTileConfigs();
    // if (tileConfigs.isNotEmpty) {
    //   _tileConfigStreamController.add(tileConfigs);
    // }
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
