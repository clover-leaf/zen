part of 'devices_overview_bloc.dart';

enum DevicesOverviewStatus {
  initializing,
  initialized,
  error,
}

extension DevicesOverviewStatusX on DevicesOverviewStatus {
  bool get isInitializing => this == DevicesOverviewStatus.initializing;

  bool get isInitialized => this == DevicesOverviewStatus.initialized;

  bool get isError => this == DevicesOverviewStatus.error;
}

class DevicesOverviewState extends Equatable {
  DevicesOverviewState({
    this.status = DevicesOverviewStatus.initializing,
    required this.projectID,
    this.projectView = const {},
    this.deviceView = const {},
  });

  /// The status of state
  final DevicesOverviewStatus status;

  /// The [FieldId] of [Project]
  final FieldId projectID;

  /// The map of [FieldId] of [Project] and it
  ///
  /// <Project.id, Project>
  final Map<FieldId, Project> projectView;

  /// The list of [Project]
  late final List<Project> projects = projectView.values.toList();

  /// The map of [FieldId] of [Device] and it
  ///
  /// <Device.id, Device>
  final Map<FieldId, Device> deviceView;

  /// The list of [Device]
  late final List<Device> devices = deviceView.values.toList();

  /// The list of [Device] belonging to [Project] with projectID
  List<Device> get showedDevices =>
      devices.where((device) => device.projectID == projectID).toList();

  DevicesOverviewState copyWith({
    DevicesOverviewStatus? status,
    FieldId? projectID,
    Map<FieldId, Project>? projectView,
    Map<FieldId, Device>? deviceView,
  }) =>
      DevicesOverviewState(
        status: status ?? this.status,
        projectID: projectID ?? this.projectID,
        projectView: projectView ?? this.projectView,
        deviceView: deviceView ?? this.deviceView,
      );

  @override
  List<Object> get props => [status, projectID, projectView, deviceView];
}
