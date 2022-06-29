part of 'device_detail_bloc.dart';

enum DeviceDetailStatus {initial, success, failure}

class DeviceDetailState extends Equatable {
  const DeviceDetailState({
    this.status = DeviceDetailStatus.success,
    required this.device,
  });
  
  final DeviceDetailStatus status;
  final Device device;
  
  @override
  List<Object> get props => [status, device];
}
