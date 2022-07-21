import 'package:equatable/equatable.dart';
import 'package:iot_api/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'generated/tile_config.g.dart';

@immutable
@JsonSerializable()

///
class TileConfig extends Equatable {
  ///
  const TileConfig({
    required this.title,
    required this.deviceID,
    required this.tileType,
    required this.tileData,
  });

  /// The title of tile
  final String title;

  /// The device that tile monitored
  final String deviceID;

  /// The tileType of tile
  final TileType tileType;

  /// The display setting of tile
  final TileData tileData;

  /// Deserializes the given [JsonMap] into a [TileConfig].
  static TileConfig fromJson(JsonMap json) => _$TileConfigFromJson(json);

  /// Converts this [TileConfig] into a [JsonMap].
  JsonMap toJson() => _$TileConfigToJson(this);

  /// return a copy of [TileConfig] with given parameters
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
    return [title, deviceID, tileType, tileData];
  }
}
