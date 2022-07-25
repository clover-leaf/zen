part of 'device_bloc.dart';

class DeviceEvent extends Equatable {
  const DeviceEvent();

  @override
  List<Object> get props => [];
}

class DeviceStatusChanged extends DeviceEvent {
  const DeviceStatusChanged(this.status);

  final DeviceStatus status;

  @override
  List<Object> get props => [status];
}

class GetAllDevice extends DeviceEvent {
  const GetAllDevice();

  @override
  List<Object> get props => [];
}
