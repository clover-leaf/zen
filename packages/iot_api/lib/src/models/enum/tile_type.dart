/// Tile category
enum TileType {
  ///
  toggle,

  /// 
  text,
}

/// helper
extension TileTypeX on TileType {
  /// convert [TileType] to [String]
  String toJsonKey() {
    switch (this) {
      case TileType.toggle:
        return 'toggle';
      case TileType.text:
        return 'text';
    }
  }

  /// convert [String] to [TileType]
  static TileType fromString(String title) {
    switch (title) {
      case 'toggle':
        return TileType.toggle;
      case 'text':
        return TileType.text;
      default:
        throw Exception('cant find matched block type');
    }
  }
}
