import 'package:equatable/equatable.dart';
import 'package:iot_api/iot_api.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'generated/project.g.dart';

@immutable
@JsonSerializable()

/// {@template iot_api}
/// Project models for an API providing to access project.
/// {@endtemplate}
class Project extends Equatable {
  /// {macro Project}
  Project({
    String? id,
    required this.key,
    required this.name,
    this.description,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  /// The project ID
  final FieldId id;

  /// The key of project
  final String key;

  /// The name of project
  final String name;

  /// The description of project
  final String? description;

  /// The created date of project
  @JsonKey(name: 'create_at')
  final DateTime? createdAt;

  /// The [FieldId] of user created
  @JsonKey(name: 'create_by')
  final FieldId? createdBy;

  /// The updatedd date of project
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  /// The [FieldId] of user created
  @JsonKey(name: 'updated_by')
  final FieldId? updatedBy;

  /// Deserializes the given [JsonMap] into a [Project].
  static Project fromJson(JsonMap json) {
    return _$ProjectFromJson(json);
  }

  /// Converts this [Project] into a [JsonMap].
  JsonMap toJson() => _$ProjectToJson(this);

  /// Returns a copy of [Project] with given parameters
  Project copyWith({
    FieldId? id,
    String? key,
    String? name,
    String? description,
    DateTime? createdAt,
    FieldId? createdBy,
    DateTime? updatedAt,
    FieldId? updatedBy,
  }) {
    return Project(
      id: id ?? this.id,
      key: key ?? this.key,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }

  @override
  List<Object?> get props => [
        id,
        key,
        name,
        description,
        createdAt,
        createdBy,
        updatedAt,
        updatedBy,
      ];
}
