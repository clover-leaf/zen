import 'package:equatable/equatable.dart';
import 'package:iot_api/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'generated/tile_config.g.dart';

@immutable
@JsonSerializable()

/// {@template iot_api}
/// TileConfig model for an API providing to access tile config.
/// {@endtemplate}
class TileConfig extends Equatable {
  /// {@macro TileConfig}
  TileConfig({
    FieldId? id,
    required this.name,
    required this.deviceID,
    required this.tileType,
    required this.tileData,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  /// The id of tile
  final FieldId id;

  /// The name of tile
  final String name;

  @JsonKey(name: 'device_id')
  /// The id of [Device] that tile monitored
  final FieldId deviceID;

  @JsonKey(name: 'tile_type')
  /// The type of tile
  final TileType tileType;

  @JsonKey(name: 'tile_data')
  /// The data of tile
  final TileData tileData;

  /// Deserializes the given [JsonMap] into a [TileConfig]
  static TileConfig fromJson(JsonMap json) => _$TileConfigFromJson(json);

  /// Converts this [TileConfig] into a [JsonMap]
  JsonMap toJson() => _$TileConfigToJson(this);

  /// Returns a copy of [TileConfig] with given parameters
  TileConfig copyWith({
    FieldId? id,
    String? name,
    FieldId? deviceID,
    TileType? tileType,
    TileData? tileData,
  }) {
    return TileConfig(
      id: id ?? this.id,
      name: name ?? this.name,
      deviceID: deviceID ?? this.deviceID,
      tileType: tileType ?? this.tileType,
      tileData: tileData ?? this.tileData,
    );
  }

  @override
  List<Object?> get props {
    return [id, name, deviceID, tileType, tileData];
  }
}
