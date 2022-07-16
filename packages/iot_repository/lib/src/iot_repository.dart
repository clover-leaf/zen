import 'package:iot_api/iot_api.dart';

/// {@template iot_repository}
/// A repository that handles iot related requests.
/// {@endtemplate}
class IotRepository {
  /// {@macro iot_repository}
  const IotRepository({
    required IotApi api,
  }) : _api = api;

  final IotApi _api;

  /// Get total number of [Project],
  ///
  Future<int> countProject() async {
    return _api.countProject();
  }

  /// Get all [Project] in schema with given params,
  ///
  Future<List<Project>> getNProject({
    int startIndex = 0,
    int count = 10,
  }) async {
    return _api.getNProject(
      startIndex: startIndex,
      count: count,
    );
  }

  /// Get all [Station] of a [Project] that given id
  ///
  Future<List<Station>> getAllStationInProject({required int projectId}) async {
    return _api.getAllStationInProject(projectId: projectId);
  }

  /// Get all [Device] of a [Project] that given id
  ///
  Future<List<Device>> getAllDeviceInProject({required int projectId}) async {
    return _api.getAllDeviceInProject(projectId: projectId);
  }

  /// Get all [Device] of a [Station] that given id
  ///
  Future<List<Device>> getAllDeviceInStation({required int stationId}) async {
    return _api.getAllDeviceInStation(stationId: stationId);
  }
  
  /// return stream of data for dashboard
  Stream<List<LiveData>> fetchLiveData() {
    return _api.fetchLiveData();
  }
}
