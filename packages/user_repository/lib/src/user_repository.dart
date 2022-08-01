import 'package:iot_api/iot_api.dart';
import 'package:iot_gateway/iot_gateway.dart';
import 'package:supabase_auth_client/supabase_auth_client.dart';
import 'package:supabase_database_client/supabase_database_client.dart';
import 'package:user_repository/user_repository.dart';

/// {@template user_repository}
/// A package which manages the user domain.
/// {@endtemplate}
class UserRepository {
  /// {@macro user_repository}
  UserRepository({
    required SupabaseAuthClient authClient,
    required SupabaseDatabaseClient databaseClient,
    required IotGateway iotGateway,
  })  : _authClient = authClient,
        _databaseClient = databaseClient,
        _iotGateway = iotGateway;

  final SupabaseAuthClient _authClient;
  final SupabaseDatabaseClient _databaseClient;
  final IotGateway _iotGateway;

  /// Method to access the current user.
  Future<User> getUser() async {
    final supabaseUser = await _databaseClient.getUserProfile();
    return supabaseUser.toUser();
  }

  /// Method to update user information on profiles database.
  Future<void> updateUser({required User user}) {
    return _databaseClient.updateUser(user: user.toSupabaseUser());
  }

  /// Method to do signIn.
  Future<void> signIn({required String email, required bool isWeb}) async {
    return _authClient.signIn(email: email, isWeb: isWeb);
  }

  /// Method to do signOut.
  Future<void> signOut() async => _authClient.signOut();

  /// Get latest [List] of [Project]
  Future<void> refresh() => _databaseClient.refresh();

  /// Get latest [List] of [TileConfig]
  Future<List<TileConfig>> fetchTileConfigs() =>
      _databaseClient.fetchTileConfigs();

  /// Gets the [Stream] of [List] of [Project]
  Stream<List<Project>> getProjects() => _databaseClient.getProjects();

  /// Gets the [Stream] of [List] of [Device]
  Stream<List<Device>> getDevices() => _databaseClient.getDevices();

  /// Gets the [Stream] of [List] of [TileConfig]
  Stream<List<TileConfig>> getTileConfigs() => _databaseClient.getTileConfigs();

  /// Saves [TileConfig]
  Future<void> saveTileConfig(TileConfig tileConfig) {
    return _databaseClient.saveTileConfig(tileConfig);
  }
  /// Updates [TileConfig]
  Future<void> updateTileConfig(TileConfig tileConfig) {
    return _databaseClient.updateTileConfig(tileConfig);
  }

  /// If this [TileConfig] existed in db, deletes it
  Future<void> deleteTileConfig(TileConfig tileConfig) {
    return _databaseClient.deleteTileConfig(tileConfig);
  }

  /// Saves [Device]
  Future<void> saveDevice(Device device,  String projectKey) {
    return _databaseClient.saveDevice(device, projectKey);
  }

  /// Updates [Device]
  Future<void> updateDevice(Device device,  String projectKey, String oldKey) {
    return _databaseClient.updateDevice(device, projectKey, oldKey);
  }

  /// If this [Device] existed in db, deletes it
  Future<void> deleteDevice(Device device) {
    return _databaseClient.deleteDevice(device);
  }

  /// Saves [Project]
  Future<void> saveProject(Project project) {
    return _databaseClient.saveProject(project);
  }

  /// Saves [Project]
  Future<void> updateProject(Project project, String oldKey) {
    return _databaseClient.updateProject(project, oldKey);
  }

  /// If this [Project] existed in db, deletes it
  Future<void> deleteProject(Project project) {
    return _databaseClient.deleteProject(project);
  }

  /// gets a stream of data from [Broker]
  Stream<List<String>> getPublishMsg(GatewayClient client) {
    return _iotGateway.getPublishMsg(client);
  }

  /// creates [GatewayClient] with given [Broker]
  GatewayClient createClient() {
    return _iotGateway.createClient();
  }

  /// Gets a [Stream] of [ConnectionStatus] from given [GatewayClient]
  Stream<ConnectionStatus> getConnectionStatus(GatewayClient client) {
    return _iotGateway.getConnectionStatus(client);
  }
}

extension on SupabaseUser {
  User toUser() {
    return User(
      id: id,
      userName: userName,
      companyName: companyName,
    );
  }
}

extension on User {
  SupabaseUser toSupabaseUser() {
    return SupabaseUser(
      id: id,
      userName: userName,
      companyName: companyName,
    );
  }
}
