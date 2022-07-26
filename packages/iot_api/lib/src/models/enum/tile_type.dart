/// Tile category
enum TileType {
  ///
  toggle,

  /// 
  text,
}

/// helper
extension TileTypeX on TileType {
  /// convert [TileType] to [String] to display
  String toTitle() {
    switch (this) {
      case TileType.toggle:
        return 'Toggle';
      case TileType.text:
        return 'Text';
    }
  }

  /// convert [TileType] to [String] to convert into JSON
  int toJsonKey() {
    switch (this) {
      case TileType.toggle:
        return 0;
      case TileType.text:
        return 1;
    }
  }

  /// convert [String] to [TileType]
  static TileType fromJsonKey(int key) {
    switch (key) {
      case 0:
        return TileType.toggle;
      case 1:
        return TileType.text;
      default:
        throw Exception('cant find matched block type');
    }
  }
}
