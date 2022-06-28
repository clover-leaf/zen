/// Status of device
enum Status {

  ///
  stop,

  /// 
  running,
}

/// helper
extension StatusX on Status {
  /// get name
  String getName() {
    switch (this) {
      case Status.stop:
        return 'Stop';
      case Status.running:
        return 'Running';
    }
  }
}
