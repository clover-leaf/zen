/// Status of device
enum DeviceType {

  ///
  sensor,

  /// 
  gadget,

  ///
  appliance
}

/// helper
extension DeviceTypeX on DeviceType {
  /// get name
  String getName() {
    switch (this) {
      case DeviceType.sensor:
        return 'Sensor';
      case DeviceType.gadget:
        return 'Gadget';
      case DeviceType.appliance:
        return 'Appliance';
    }
  }
}
