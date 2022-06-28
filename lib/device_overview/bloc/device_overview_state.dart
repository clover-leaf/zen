part of 'device_overview_bloc.dart';

enum DeviceOverviewStatus { loading, success }

class DeviceOverviewState extends Equatable {
  const DeviceOverviewState({
    this.devices = const [],
    this.status = DeviceOverviewStatus.loading,
    this.filter = const DeviceOverviewFilter(),
  });

  final List<Device> devices;
  final DeviceOverviewStatus status;
  final DeviceOverviewFilter filter;

  Iterable<Device> get processedExams => filter.applyAll(devices);

  DeviceOverviewState copyWith({
    List<Device> Function()? devices,
    DeviceOverviewStatus Function()? status,
    DeviceOverviewFilter Function()? filter,
  }) {
    return DeviceOverviewState(
      status: status != null ? status() : this.status,
      devices: devices != null ? devices() : this.devices,
      filter: filter != null ? filter() : this.filter,
    );
  }

  @override
  List<Object> get props => [status, devices, filter];
}
