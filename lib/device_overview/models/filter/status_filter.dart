import 'package:iot_api/iot_api.dart';

enum DeviceOverviewStatusFilter { all, running, stop }

extension DeviceOverviewStatusFilterX on DeviceOverviewStatusFilter {
  bool apply(Device device) {
    switch (this) {
      case DeviceOverviewStatusFilter.all:
        return true;
      case DeviceOverviewStatusFilter.stop:
        return device.status == Status.stop;
      case DeviceOverviewStatusFilter.running:
        return device.status == Status.running;
    }
  }

  String getName() {
    switch (this) {
      case DeviceOverviewStatusFilter.all:
        return 'Any status';
      case DeviceOverviewStatusFilter.stop:
        return Status.stop.getName();
      case DeviceOverviewStatusFilter.running:
        return Status.running.getName();
    }
  }
}
