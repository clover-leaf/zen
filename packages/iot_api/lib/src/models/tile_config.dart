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
  final FieldId id;

  /// The title of tile
  final String title;

  /// The id of [Device] that tile monitored
  final FieldId deviceID;

  /// The type of tile
  final TileType tileType;

  /// The data of tile
  final TileData tileData;

  /// Deserializes the given [JsonMap] into a [TileConfig]
  static TileConfig fromJson(JsonMap json) => _$TileConfigFromJson(json);

  /// Converts this [TileConfig] into a [JsonMap]
  JsonMap toJson() => _$TileConfigToJson(this);

  /// Returns a copy of [TileConfig] with given parameters
  TileConfig copyWith({
    FieldId? id,
    String? title,
    FieldId? deviceID,
    TileType? tileType,
    TileData? tileData,
  }) {
    return TileConfig(
      id: id ?? this.id,
      title: title ?? this.title,
      deviceID: deviceID ?? this.deviceID,
      tileType: tileType ?? this.tileType,
      tileData: tileData ?? this.tileData,
    );
  }

  @override
  List<Object?> get props {
    return [id, title, deviceID, tileType, tileData];
  }
}
