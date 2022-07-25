/// Tile category
enum SnackBarType {
  ///
  warning,

  /// 
  error,

  /// 
  info,
}

/// helper
extension SnackBarTypeX on SnackBarType {

  bool isWarning() => this == SnackBarType.warning;

  bool isError() => this == SnackBarType.error;
  
  bool isInfo() => this == SnackBarType.info;
}
