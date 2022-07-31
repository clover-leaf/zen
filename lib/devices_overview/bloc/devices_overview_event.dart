part of 'devices_overview_bloc.dart';

class DevicesOverviewEvent extends Equatable {
  const DevicesOverviewEvent();

  @override
  List<Object> get props => [];
}

class InitializeRequested extends DevicesOverviewEvent {
  const InitializeRequested();
}

class ProjectSubscriptionRequested extends DevicesOverviewEvent {
  const ProjectSubscriptionRequested();
}

class DeviceSubscriptionRequested extends DevicesOverviewEvent {
  const DeviceSubscriptionRequested();
}
