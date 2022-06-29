
import 'package:iot_api/iot_api.dart';

/// {@template iot_repository}
/// A repository that handles iot related requests.
/// {@endtemplate}
class IotRepository {
  /// {@macro iot_repository}
  const IotRepository({
    required IotApi iotApi,
  }) : _iotApi = iotApi;

  final IotApi _iotApi;

  /// fetchs devices list
  Future<List<Device>> fetchDevices({
    int startIndex = 0,
    int count = 5,
  }) async {
    final devices =
        await _iotApi.fetchDevices(startIndex: startIndex, count: count);
    return devices;
  }

  /// return stream of data for dashboard
  Stream<List<double>> fetchLiveData() {
    return _iotApi.fetchLiveData();
  }
}
