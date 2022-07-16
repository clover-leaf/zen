part of 'device_detail_new_bloc.dart';

class DeviceDetailNewEvent extends Equatable {
  const DeviceDetailNewEvent();

  @override
  List<Object> get props => [];
}

class DeviceDetailTabChanged extends DeviceDetailNewEvent {
  const DeviceDetailTabChanged(this.tab);

  final DeviceDetailTab tab;

  @override
  List<Object> get props => [tab];
}
