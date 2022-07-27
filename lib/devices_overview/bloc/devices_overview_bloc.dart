import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

part 'devices_overview_event.dart';
part 'devices_overview_state.dart';

class DevicesOverviewBloc
    extends Bloc<DevicesOverviewEvent, DevicesOverviewState> {
  DevicesOverviewBloc({
    required this.repository,
    required FieldId projectID,
  }) : super(DevicesOverviewState(projectID: projectID)) {
    on<InitializeRequested>(_onInitializeRequested);
    on<DeviceSubscriptionRequested>(_onDeviceSubscriptionRequested);
  }

  /// The IoT repository instance
  final IotRepository repository;

  /// Initializes
  void _onInitializeRequested(
    InitializeRequested event,
    Emitter<DevicesOverviewState> emit,
  ) {
    add(const DeviceSubscriptionRequested());
    emit(state.copyWith(status: DevicesOverviewStatus.initialized));
  }

  /// Subcribes [Stream] of [List] of [Device]
  Future<void> _onDeviceSubscriptionRequested(
    DeviceSubscriptionRequested event,
    Emitter<DevicesOverviewState> emit,
  ) async {
    await emit.forEach<List<Device>>(
      repository.getDevices(),
      onData: (devices) {
        final deviceView = {for (var device in devices) device.id: device};
        return state.copyWith(deviceView: deviceView);
      },
    );
  }
}
