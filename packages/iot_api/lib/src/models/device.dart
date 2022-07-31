import 'package:equatable/equatable.dart';
import 'package:iot_api/iot_api.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'generated/device.g.dart';

@immutable
@JsonSerializable()

/// {@template iot_api}
/// Device models for an API providing to access device.
/// {@endtemplate}
class Device extends Equatable {
  /// {macro Device}
  Device({
    FieldId? id,
    required this.projectID,
    required this.key,
    required this.name,
    this.description,
    required this.jsonEnable,
    required this.jsonVariables,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  /// The device ID
  final FieldId id;

  /// The ID [Project] that device is belonged to
  @JsonKey(name: 'project_id')
  final FieldId projectID;

  /// The name of key on broker
  final String key;

  /// The name of device
  final String name;

  /// The description of device
  final String? description;

  /// The boolean that determines whether using JSON extraction
  @JsonKey(name: 'json_enable')
  final bool jsonEnable;

  /// The list of [JsonVariable] of device
  @JsonKey(name: 'json_variables')
  final List<JsonVariable> jsonVariables;

  /// The list of [JsonVariable] of device
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  /// The list of [JsonVariable] of device
  @JsonKey(name: 'created_by')
  final FieldId? createdBy;

  /// The list of [JsonVariable] of device
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  /// The list of [JsonVariable] of device
  @JsonKey(name: 'updated_by')
  final FieldId? updatedBy;

  /// Deserializes the given [JsonMap] into a [Device].
  static Device fromJson(JsonMap json) => _$DeviceFromJson(json);

  /// Converts this [Device] into a [JsonMap].
  JsonMap toJson() => _$DeviceToJson(this);

  /// Returns a copy of [Device] with given parameters
  Device copyWith({
    FieldId? id,
    FieldId? projectID,
    String? key,
    String? name,
    String? description,
    bool? jsonEnable,
    List<JsonVariable>? jsonVariables,
    DateTime? createdAt,
    FieldId? createdBy,
    DateTime? updatedAt,
    FieldId? updatedBy,
  }) {
    return Device(
      id: id ?? this.id,
      projectID: projectID ?? this.projectID,
      key: key ?? this.key,
      name: name ?? this.name,
      description: description ?? this.description,
      jsonEnable: jsonEnable ?? this.jsonEnable,
      jsonVariables: jsonVariables ?? this.jsonVariables,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }

  @override
  List<Object?> get props => [
        id,
        projectID,
        key,
        name,
        description,
        jsonEnable,
        jsonVariables,
        createdAt,
        createdBy,
        updatedAt,
        updatedBy,
      ];
}
