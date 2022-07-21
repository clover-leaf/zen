/// Status of device
enum AlertLevel {

  ///
  low,

  /// 
  normal,

  ///
  high
}

/// helper
extension AlertLevelX on AlertLevel {
  /// get name
  String getName() {
    switch (this) {
      case AlertLevel.low:
        return 'Low';
      case AlertLevel.normal:
        return 'Normal';
      case AlertLevel.high:
        return 'High';
    }
  }
}
