part of 'device_bloc.dart';

enum LoadingStatus { loading, success, failure}

enum DeviceStatus { all, active, inactive }

extension DeviceStatusX on DeviceStatus {
  String getName() {
    switch (this) {
      case DeviceStatus.all:
        return 'All devices';
      case DeviceStatus.active:
        return 'Active';
      case DeviceStatus.inactive:
        return 'Inactive';
    }
  }
}

final List<DashboardInfo> dashboardInfos = [
  DashboardInfo(
    name: 'Air Quality',
    totalStation: 4,
    iconPath: SvgIcon.air,
  ),
  DashboardInfo(
    name: 'EV Charger',
    totalStation: 3,
    iconPath: SvgIcon.gasStation,
  ),
  DashboardInfo(
    name: 'House Lighting',
    totalStation: 6,
    iconPath: SvgIcon.lighting,
  ),
  DashboardInfo(
    name: 'Water Monitor',
    totalStation: 4,
    iconPath: SvgIcon.water,
  ),
  DashboardInfo(
    name: 'Enviroment Monitor',
    totalStation: 8,
    iconPath: SvgIcon.enviroment,
  ),
  DashboardInfo(
    name: 'Building Monitor',
    totalStation: 6,
    iconPath: SvgIcon.enviroment,
  ),
];

const deviceInfos =  <DeviceInfo>[
  DeviceInfo(
    name: 'Charging port A',
    project: 'EV Charger',
    station: 'Dallas Station',
    isActive: true,
  ),
  DeviceInfo(
    name: 'Charging port B',
    project: 'EV Charger',
    station: 'Dallas Station',
    isActive: true,
  ),
  DeviceInfo(
    name: 'Charging port C',
    project: 'EV Charger',
    station: 'Dallas Station',
    isActive: true,
  ),
  DeviceInfo(
    name: 'Light #03',
    project: 'House Lighting',
    station: 'Living Room',
    isActive: false,
  ),
];

class DeviceState extends Equatable {
  const DeviceState({
    this.status = LoadingStatus.loading,
    this.deviceStatus = DeviceStatus.all,
    this.devices = const [],
  });

  final LoadingStatus status;
  final DeviceStatus deviceStatus;
  final List<Device> devices;

  DeviceState copyWith({
    LoadingStatus? status,
    DeviceStatus? deviceStatus,
    List<Device>? devices,
  }) {
    return DeviceState(
      status: status ?? this.status,
      deviceStatus: deviceStatus ?? this.deviceStatus,
      devices: devices ?? this.devices,
    );
  }

  

  @override
  List<Object> get props => [status, deviceStatus, devices];
}
