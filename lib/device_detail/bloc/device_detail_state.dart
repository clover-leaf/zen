part of 'device_detail_bloc.dart';

enum DeviceDetailStatus {loading, success}

class DeviceDetailState extends Equatable {
  const DeviceDetailState({
    this.status = DeviceDetailStatus.loading,
  });
  
  final DeviceDetailStatus status;
  
  @override
  List<Object> get props => [status];
}
