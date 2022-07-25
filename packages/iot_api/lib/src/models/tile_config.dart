// ignore_for_file: prefer_constructors_over_static_methods

import 'package:equatable/equatable.dart';
import 'package:iot_api/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'generated/tile_config.g.dart';

@immutable
@JsonSerializable()

/// {@template iot_api}
/// TileConfig model for an API providing to access config of tiles.
/// {@endtemplate}
class TileConfig extends Equatable {

  /// {@macro TileConfig}
  TileConfig({
    String? id,
    required this.title,
    required this.deviceID,
    required this.tileType,
    required this.tileData,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  /// The id of tile
  final String id;

  /// The title of tile
  final String title;

  /// The id of [MqttDevice] that tile monitored
  final String deviceID;

  /// The type of tile
  final TileType tileType;

  /// The data of tile
  final TileData tileData;

  /// The constructor that creates empty instance
  static TileConfig placeholder({required TileType tileType}) {
    return TileConfig(
      title: '',
      deviceID: '',
      tileType: tileType,
      tileData: TileData.placeholder(tileType: tileType),
    );
  }

  /// Deserializes the given [JsonMap] into a [TileConfig]
  static TileConfig fromJson(JsonMap json) => _$TileConfigFromJson(json);

  /// Converts this [TileConfig] into a [JsonMap]
  JsonMap toJson() => _$TileConfigToJson(this);

  /// Returns a copy of [TileConfig] with given parameters
  /// 
  /// {@macro TileConfig}
  TileConfig copyWith({
    String? title,
    String? deviceID,
    TileType? tileType,
    TileData? tileData,
  }) {
    return TileConfig(
      title: title ?? this.title,
      deviceID: deviceID ?? this.deviceID,
      tileType: tileType ?? this.tileType,
      tileData: tileData ?? this.tileData,
    );
  }

  @override
  List<Object> get props {
    return [id, title, deviceID, tileType, tileData];
  }
}
