import 'package:equatable/equatable.dart';
import 'package:iot_api/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part '../generated/tile_data/text_tile_data.g.dart';

@immutable
@JsonSerializable()

/// {@template iot_api}
/// TextTileData model for an API providing to access text tile data.
/// {@endtemplate}
class TextTileData extends Equatable implements TileData {
  /// {@macro TextTileData}
  const TextTileData({
    required this.prefix,
    required this.postfix,
    required this.jsonVariableID,
  });

  /// The constructor that creates empty instance
  factory TextTileData.placeholder() {
    return const TextTileData(
      prefix: '',
      postfix: '',
      jsonVariableID: '',
    );
  }

  /// The prefix of value
  final String prefix;

  /// The postfix of value
  final String postfix;

  /// The ID [JsonVariable] that tile monitoring
  final FieldId jsonVariableID;

  @override
  FieldId getFieldId() => jsonVariableID;

  @override
  bool isFilled(Device device) {
    return !device.jsonEnable || (device.jsonEnable && jsonVariableID != '');
  }

  /// Deserializes the given [JsonMap] into a [TextTileData].
  static TextTileData fromJson(JsonMap json) {
    final _json = Map<String, dynamic>.from(json)..remove('type');
    return _$TextTileDataFromJson(_json);
  }

  @override
  TextTileData setFieldId(FieldId id) => copyWith(
        jsonVariableID: id,
      );

  /// Converts this [TextTileData] into a [JsonMap].
  @override
  JsonMap toJson() {
    /// convert instance to json
    final json = _$TextTileDataToJson(this);

    /// add type info into json
    json['type'] = TileType.text.toJsonKey();
    return json;
  }

  /// Returns a copy of [TextTileData] with given parameters
  TextTileData copyWith({
    String? prefix,
    String? postfix,
    String? jsonVariableID,
  }) {
    return TextTileData(
      prefix: prefix ?? this.prefix,
      postfix: postfix ?? this.postfix,
      jsonVariableID: jsonVariableID ?? this.jsonVariableID,
    );
  }

  @override
  List<Object?> get props => [prefix, postfix, jsonVariableID];
}
