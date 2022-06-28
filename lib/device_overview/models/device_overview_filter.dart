import 'package:equatable/equatable.dart';
import 'package:flutter_firestore/device_overview/device_overview.dart';
import 'package:iot_api/iot_api.dart';

class DeviceOverviewFilter extends Equatable {
  const DeviceOverviewFilter({
    this.statusFilter = DeviceOverviewStatusFilter.all,
    this.keyword = '',
  });

  final DeviceOverviewStatusFilter statusFilter;
  final String keyword;

  bool apply(Device device) {
    return statusFilter.apply(device) &&
        (device.deviceName != null && device.deviceName!.contains(keyword));
  }

  Iterable<Device> applyAll(Iterable<Device> exams) {
    return exams.where(apply);
  }

  DeviceOverviewFilter copyWith({
    DeviceOverviewStatusFilter? statusFilter,
    String? keyword,
  }) {
    return DeviceOverviewFilter(
      statusFilter: statusFilter ?? this.statusFilter,
      keyword: keyword ?? this.keyword,
    );
  }

  @override
  List<Object> get props => [statusFilter, keyword];
}
