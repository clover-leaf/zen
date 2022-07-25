part of 'devices_tab_bloc.dart';

enum DevicesTabStatus { loading, success, failure }

class DevicesTabState extends Equatable {
  const DevicesTabState({
    required this.project,
    this.status = DevicesTabStatus.loading,
    this.devices = const [],
  });

  final DevicesTabStatus status;
  final Project project;
  final List<Device> devices;

  DevicesTabState copyWith({
    DevicesTabStatus? status,
    Project? project,
    List<Device>? devices,
  }) =>
      DevicesTabState(
        status: status ?? this.status,
        project: project ?? this.project,
        devices: devices ?? this.devices,
      );

  @override
  List<Object> get props => [status, project, devices];
}
