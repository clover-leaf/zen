import 'package:equatable/equatable.dart';
import 'package:iot_api/src/models/enum/tile_type.dart';
import 'package:iot_api/src/models/json_map.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'generated/tile_data.g.dart';

@immutable

/// Tile data
class TileData {
  /// from Json
  factory TileData.fromJson(JsonMap json) {
    final type = TileTypeX.fromString(json['type'] as String);
    switch (type) {
      case TileType.toggle:
        return TextTileData.fromJson(json);
      case TileType.text:
        return TextTileData.fromJson(json);
    }
  }

  /// to Json
  JsonMap toJson() => <String, dynamic>{};
}

@immutable
@JsonSerializable()

///
class TextTileData extends Equatable implements TileData {
  /// macro
  const TextTileData({
    this.prefix,
    this.postfix,
    this.jsonExtraction,
  });

  /// prefix of value
  final String? prefix;

  /// postfix of value
  final String? postfix;

  /// jsonExtraction value
  /// more info at https://github.com/f3ath/jessie
  final String? jsonExtraction;

  /// Deserializes the given [JsonMap] into a [TextTileData].
  static TextTileData fromJson(JsonMap json) {
    final _json = Map<String, dynamic>.from(json)..remove('type');
    return _$TextTileDataFromJson(_json);
  }

  @override

  /// Converts this [TextTileData] into a [JsonMap].
  JsonMap toJson() {
    /// convert instance to json
    final json = _$TextTileDataToJson(this);

    /// add type info into json
    json['type'] = TileType.text.toJsonKey();
    return json;
  }

  /// return a copy of [TextTileData] with given parameters
  TextTileData copyWith({
    String? prefix,
    String? postfix,
    String? jsonExtraction,
  }) {
    return TextTileData(
      prefix: prefix ?? this.prefix,
      postfix: postfix ?? this.postfix,
      jsonExtraction: jsonExtraction ?? this.jsonExtraction,
    );
  }

  @override
  List<Object?> get props => [prefix, postfix, jsonExtraction];
}
