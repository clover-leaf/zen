import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iot_api/iot_api.dart';
import 'package:user_repository/user_repository.dart';

part 'devices_overview_event.dart';
part 'devices_overview_state.dart';

class DevicesOverviewBloc
    extends Bloc<DevicesOverviewEvent, DevicesOverviewState> {
  DevicesOverviewBloc({
    required this.repository,
    required FieldId projectID,
  }) : super(DevicesOverviewState(projectID: projectID)) {
    on<InitializeRequested>(_onInitializeRequested);
    on<ProjectSubscriptionRequested>(_onProjectSubscriptionRequested);
    on<DeviceSubscriptionRequested>(_onDeviceSubscriptionRequested);
  }

  /// The IoT repository instance
  final UserRepository repository;

  /// Initializes
  void _onInitializeRequested(
    InitializeRequested event,
    Emitter<DevicesOverviewState> emit,
  ) {
    add(const DeviceSubscriptionRequested());
    add(const ProjectSubscriptionRequested());
    emit(state.copyWith(status: DevicesOverviewStatus.initialized));
  }

  /// Subcribes [Stream] of [List] of [Project]
  Future<void> _onProjectSubscriptionRequested(
    ProjectSubscriptionRequested event,
    Emitter<DevicesOverviewState> emit,
  ) async {
    await emit.forEach<List<Project>>(
      repository.getProjects(),
      onData: (projects) {
        final projectView = {for (var project in projects) project.id: project};
        if (!projectView.keys.contains(state.projectID)) {
          emit(state.copyWith(status: DevicesOverviewStatus.error));
        }
        return state.copyWith(projectView: projectView);
      },
    );
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
