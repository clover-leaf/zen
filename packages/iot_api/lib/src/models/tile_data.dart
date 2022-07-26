import 'package:iot_api/src/models/models.dart';
import 'package:meta/meta.dart';

@immutable

/// {@template iot_api}
/// TileData model for an API providing to access tile data.
/// {@endtemplate}
class TileData {
  /// The constructor that creates empty instance
  factory TileData.placeholder({required TileType tileType}) {
    switch (tileType) {
      case TileType.toggle:
        return ToggleTileData.placeholder();
      case TileType.text:
        return TextTileData.placeholder();
    }
  }

  /// Gets the id [JsonVariable] of tile
  FieldId getFieldId() => '';

  /// Deserializes the given [JsonMap] into a [TileData]
  factory TileData.fromJson(JsonMap json) {
    final type = TileTypeX.fromJsonKey(json['type'] as int);
    switch (type) {
      case TileType.toggle:
        return ToggleTileData.fromJson(json);
      case TileType.text:
        return TextTileData.fromJson(json);
    }
  }

  /// Converts this [TileConfig] into a [JsonMap]
  JsonMap toJson() => <String, dynamic>{};

  /// Checks whether every needed fields are filled
  /// 
  /// It takes a [Device] param to detect whether
  /// JSON extraction is used
  bool isFill(Device device) {
    return false;
  }
}
