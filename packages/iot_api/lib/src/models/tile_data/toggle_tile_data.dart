// ignore_for_file: prefer_constructors_over_static_methods

import 'package:equatable/equatable.dart';
import 'package:iot_api/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part '../generated/tile_data/toggle_tile_data.g.dart';

@immutable
@JsonSerializable()

/// {@template iot_api}
/// ToggleTileField model for an API providing to access data of toggle tile.
/// {@endtemplate}
class ToggleTileData extends Equatable implements TileData {
  /// {@macro TextTileData}
  const ToggleTileData({
    required this.onLabel,
    required this.onValue,
    required this.offLabel,
    required this.offValue,
    required this.jsonEnable,
    required this.jsonExtraction,
  });

  /// The label of tile when button on
  final String onLabel;

  /// The value of tile when button on
  final String onValue;

  /// The label of tile when button off
  final String offLabel;

  /// The value of tile when button off
  final String offValue;

  /// The boolean that determines whether using JSON extraction
  final bool jsonEnable;

  /// The JSON extraction value
  /// 
  /// more info at https://github.com/f3ath/jessie
  final String jsonExtraction;

  /// The constructor that creates empty instance
  static ToggleTileData placeholder() {
    return const ToggleTileData(
      onLabel: 'ON',
      onValue: '1',
      offLabel: 'OFF',
      offValue: '0',
      jsonEnable: false,
      jsonExtraction: '',
    );
  }

  @override
  bool isFill() {
  // return whether onValue and offValue is described
    return onValue != '' && offValue != '';
  }

  /// Deserializes the given [JsonMap] into a [ToggleTileData].
  static ToggleTileData fromJson(JsonMap json) {
    final _json = Map<String, dynamic>.from(json)..remove('type');
    return _$ToggleTileDataFromJson(_json);
  }

  @override
  /// Converts this [ToggleTileData] into a [JsonMap].
  JsonMap toJson() {
    /// convert instance to json
    final json = _$ToggleTileDataToJson(this);

    /// add type info into json
    json['type'] = TileType.toggle.toJsonKey();
    return json;
  }

  /// Return a copy of [ToggleTileData] with given parameters
  /// 
  /// {@macro ToggleTileData}
  ToggleTileData copyWith({
    String? onLabel,
    String? onValue,
    String? offLabel,
    String? offValue,
    bool? jsonEnable,
    String? jsonExtraction,
  }) {
    return ToggleTileData(
      onLabel: onLabel ?? this.onLabel,
      onValue: onValue ?? this.onValue,
      offLabel: offLabel ?? this.offLabel,
      offValue: offValue ?? this.offValue,
      jsonEnable: jsonEnable ?? this.jsonEnable,
      jsonExtraction: jsonExtraction ?? this.jsonExtraction,
    );
  }

  @override
  List<Object?> get props =>
      [onLabel, onValue, offLabel, offValue, jsonEnable, jsonExtraction];
}
