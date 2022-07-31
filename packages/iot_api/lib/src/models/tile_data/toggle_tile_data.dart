import 'package:equatable/equatable.dart';
import 'package:iot_api/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part '../generated/tile_data/toggle_tile_data.g.dart';

@immutable
@JsonSerializable()

/// {@template iot_api}
/// ToggleTileField model for an API providing to access toggle tile data.
/// {@endtemplate}
class ToggleTileData extends Equatable implements TileData {
  /// {@macro TextTileData}
  const ToggleTileData({
    required this.onLabel,
    required this.onValue,
    required this.offLabel,
    required this.offValue,
    required this.jsonVariableID,
  });

  /// The constructor that creates empty instance
  factory ToggleTileData.placeholder() {
    return const ToggleTileData(
      onLabel: null,
      onValue: null,
      offLabel: null,
      offValue: null,
      jsonVariableID: null,
    );
  }

  /// The label of tile when button on
  final String? onLabel;

  /// The value of tile when button on
  final String? onValue;

  /// The label of tile when button off
  final String? offLabel;

  /// The value of tile when button off
  final String? offValue;

  /// The ID [JsonVariable] that tile monitoring
  final FieldId? jsonVariableID;

  @override
  FieldId? getFieldId() => jsonVariableID;

  @override
  bool isFilled(Device device) {
    final jsonCondition =
        !device.jsonEnable || (device.jsonEnable && jsonVariableID != null);
    final onValueCondition = onValue != null && onValue != '';
    final offValueCondition = offValue != null && offValue != '';
    return onValueCondition && offValueCondition && jsonCondition;
  }

  /// Deserializes the given [JsonMap] into a [ToggleTileData].
  static ToggleTileData fromJson(JsonMap json) {
    final _json = Map<String, dynamic>.from(json)..remove('tileType');
    return _$ToggleTileDataFromJson(_json);
  }

  @override
  ToggleTileData setFieldId(FieldId? id) => copyWith(
        jsonVariableID: id,
      );

  /// Converts this [ToggleTileData] into a [JsonMap].
  @override
  JsonMap toJson() {
    /// convert instance to json
    final json = _$ToggleTileDataToJson(this);

    /// add type info into json
    json['tileType'] = TileType.toggle.toJsonKey();
    return json;
  }

  /// Return a copy of [ToggleTileData] with given parameters
  ToggleTileData copyWith({
    String? onLabel,
    String? onValue,
    String? offLabel,
    String? offValue,
    bool? jsonEnable,
    FieldId? jsonVariableID,
  }) {
    return ToggleTileData(
      onLabel: onLabel ?? this.onLabel,
      onValue: onValue ?? this.onValue,
      offLabel: offLabel ?? this.offLabel,
      offValue: offValue ?? this.offValue,
      jsonVariableID: jsonVariableID ?? this.jsonVariableID,
    );
  }

  @override
  List<Object?> get props =>
      [onLabel, onValue, offLabel, offValue, jsonVariableID];
}
