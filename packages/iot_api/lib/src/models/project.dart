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
    required this.title,
    required this.brokerID,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  /// The project ID
  final String id;

  /// The title of project
  final String title;

  /// The ID [Broker] of project
  final FieldId brokerID;

  /// Deserializes the given [JsonMap] into a [Project].
  static Project fromJson(JsonMap json) {
    return _$ProjectFromJson(json);
  }

  /// Converts this [Project] into a [JsonMap].
  JsonMap toJson() => _$ProjectToJson(this);

  /// Returns a copy of [Project] with given parameters
  Project copyWith({
    String? id,
    String? title,
    FieldId? brokerID,
  }) {
    return Project(
      id: id ?? this.id,
      title: title ?? this.title,
      brokerID: brokerID ?? this.brokerID,
    );
  }

  @override
  List<Object> get props => [id, title, brokerID];
}
