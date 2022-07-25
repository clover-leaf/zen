part of 'device_detail_bloc.dart';

enum DeviceDetailTab { infomation , indicators}

extension DeviceDetailTabX on DeviceDetailTab {
  String getName() {
    switch (this) {
      case DeviceDetailTab.infomation:
        return 'INFO';
      case DeviceDetailTab.indicators:
        return 'INDICATORS';
    }
  }
}

class DeviceDetailState extends Equatable {
  const DeviceDetailState({
    this.tab = DeviceDetailTab.infomation,
    required this.device,
  });

  final Device device;
  final DeviceDetailTab tab;

  DeviceDetailState copyWith({
    Device? device,
    DeviceDetailTab? tab,
  }) {
    return DeviceDetailState(
      device: device ?? this.device,
      tab: tab ?? this.tab,
    );
  }

  @override
  List<Object> get props => [device, tab];
}
