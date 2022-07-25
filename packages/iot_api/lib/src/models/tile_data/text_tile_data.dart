
// ignore_for_file: prefer_constructors_over_static_methods

import 'package:equatable/equatable.dart';
import 'package:iot_api/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part '../generated/tile_data/text_tile_data.g.dart';

@immutable
@JsonSerializable()

/// {@template iot_api}
/// TextTileData model for an API providing to access data of text tile.
/// {@endtemplate}
class TextTileData extends Equatable implements TileData {
  /// {@macro TextTileData}
  const TextTileData({
    required this.prefix,
    required this.postfix,
    required this.jsonEnable,
    required this.jsonExtraction,
  });

  /// The prefix of value
  final String prefix;

  /// The postfix of value
  final String postfix;

  /// The boolean that determines whether using JSON extraction
  final bool jsonEnable;

  /// The JSON extraction value
  /// 
  /// more info at https://github.com/f3ath/jessie
  final String jsonExtraction;

  /// The constructor that creates empty instance
  static TextTileData placeholder() {
    return const TextTileData(
      prefix: '',
      postfix: '',
      jsonEnable: false,
      jsonExtraction: '',
    );
  }

  @override
  // alway returns true because every field are optional
  bool isFill() {
    return true;
  }

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

  /// Returns a copy of [TextTileData] with given parameters
  /// 
  /// {@macro TextTileData}
  TextTileData copyWith({
    String? prefix,
    String? postfix,
    bool? jsonEnable,
    String? jsonExtraction,
  }) {
    return TextTileData(
      prefix: prefix ?? this.prefix,
      postfix: postfix ?? this.postfix,
      jsonEnable: jsonEnable ?? this.jsonEnable,
      jsonExtraction: jsonExtraction ?? this.jsonExtraction,
    );
  }

  @override
  List<Object?> get props => [prefix, postfix, jsonEnable, jsonExtraction];
}
