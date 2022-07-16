part of 'device_detail_new_bloc.dart';

enum DeviceDetailNewStatus {loading, success}

enum DeviceDetailTab {infomation, location, indicator}

extension DeviceDetailTabX on DeviceDetailTab {
  String getName() {
    switch (this) {
      case DeviceDetailTab.infomation:
        return 'Infomation';
      case DeviceDetailTab.location:
        return 'Location';
      case DeviceDetailTab.indicator:
        return 'Indicator';
    }
  }
}
class DeviceDetailNewState extends Equatable {
  const DeviceDetailNewState({
    this.status = DeviceDetailNewStatus.loading,
    this.tab = DeviceDetailTab.infomation,
    required this.deviceInfo,
  });
  
  final DeviceDetailNewStatus status;
  final DeviceInfo deviceInfo;
  final DeviceDetailTab tab;
  
  DeviceDetailNewState copyWith({
    DeviceDetailNewStatus? status,
    DeviceInfo? deviceInfo,
    DeviceDetailTab? tab,
  }) {
    return DeviceDetailNewState(
      status: status ?? this.status,
      deviceInfo: deviceInfo ?? this.deviceInfo,
      tab: tab ?? this.tab,
    );
  }

  @override
  List<Object> get props => [status, deviceInfo, tab];
}
