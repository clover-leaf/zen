part of 'device_detail_bloc.dart';

class DeviceDetailEvent extends Equatable {
  const DeviceDetailEvent();

  @override
  List<Object> get props => [];
}

class TabChanged extends DeviceDetailEvent {
  const TabChanged(this.tab);

  final DeviceDetailTab tab;

  @override
  List<Object> get props => [tab];
}
