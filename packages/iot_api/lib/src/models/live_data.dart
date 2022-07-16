
/// Live data object that server reply when tracking device
/// 
class LiveData {
  /// @macro{[LiveData]}
  LiveData(this.value, this.timestamp);

  /// value of data
  final double value;
  
  /// timestamp of data
  final DateTime timestamp;
}
