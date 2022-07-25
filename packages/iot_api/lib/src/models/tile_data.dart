// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_constructors_over_static_methods, lines_longer_than_80_chars

import 'package:iot_api/src/models/models.dart';
import 'package:meta/meta.dart';

@immutable

/// {@template iot_api}
/// TileData model for an API providing to access data of tile.
/// {@endtemplate}
class TileData {
  
  /// Deserializes the given [JsonMap] into a [TileData]
  factory TileData.fromJson(JsonMap json) {
    final type = TileTypeX.fromString(json['type'] as String);
    switch (type) {
      case TileType.toggle:
        return ToggleTileData.fromJson(json);
      case TileType.text:
        return TextTileData.fromJson(json);
    }
  }

  /// Converts this [TileConfig] into a [JsonMap]
  JsonMap toJson() => <String, dynamic>{};

  /// The constructor that creates empty instance
  static TileData placeholder({required TileType tileType}) {
    switch (tileType) {
      case TileType.toggle:
        return ToggleTileData.placeholder();
      case TileType.text:
        return TextTileData.placeholder();
    }
  }

  // The method that checks whether every needed fields are filled
  bool isFill() {
    return false;
  }
}
