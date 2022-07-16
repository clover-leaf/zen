part of 'devices_tab_bloc.dart';

enum DevicesTabStatus { loading, success, failure }

class DevicesTabState extends Equatable {
  const DevicesTabState({
    required this.station,
    this.status = DevicesTabStatus.loading,
    this.devices = const [],
  });

  final DevicesTabStatus status;
  final Station station;
  final List<Device> devices;

  DevicesTabState copyWith({
    DevicesTabStatus? status,
    Station? station,
    List<Device>? devices,
  }) =>
      DevicesTabState(
        status: status ?? this.status,
        station: station ?? this.station,
        devices: devices ?? this.devices,
      );

  @override
  List<Object> get props => [status, station, devices];
}
