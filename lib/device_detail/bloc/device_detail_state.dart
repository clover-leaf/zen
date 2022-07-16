part of 'device_detail_bloc.dart';

enum DeviceDetailStatus { initial, success, failure }

enum DeviceDetailTab { overview, history, data, indicator }

extension DeviceDetailTabX on DeviceDetailTab {
  String getName() {
    switch (this) {
      case DeviceDetailTab.overview:
        return 'OVERVIEW';
      case DeviceDetailTab.data:
        return 'DATA';
      case DeviceDetailTab.indicator:
        return 'INDICATOR';
      case DeviceDetailTab.history:
        return 'HISTORY';
    }
  }
}

class DeviceDetailState extends Equatable {
  const DeviceDetailState({
    this.status = DeviceDetailStatus.success,
    this.tab = DeviceDetailTab.overview,
    required this.device,
  });

  final DeviceDetailStatus status;
  final DeviceDetailTab tab;
  final Device device;

  DeviceDetailState copyWith({
    DeviceDetailStatus? status,
    DeviceDetailTab? tab,
    Device? device,
  }) {
    return DeviceDetailState(
      status: status ?? this.status,
      tab: tab ?? this.tab,
      device: device ?? this.device,
    );
  }

  @override
  List<Object> get props => [status, tab, device];
}
