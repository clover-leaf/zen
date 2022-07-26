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
    required this.topic,
    required this.title,
    required this.jsonEnable,
    required this.jsonVariables,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  /// The device ID
  final FieldId id;

  /// The ID [Project] that device is belonged to
  final FieldId projectID;

  /// The name of topic on broker
  final String topic;

  /// The title of device
  final String title;

  /// The boolean that determines whether using JSON extraction
  final bool jsonEnable;

  /// The list of [JsonVariable] of device
  final List<JsonVariable> jsonVariables;

  /// Deserializes the given [JsonMap] into a [Device].
  static Device fromJson(JsonMap json) => _$DeviceFromJson(json);

  /// Converts this [Device] into a [JsonMap].
  JsonMap toJson() => _$DeviceToJson(this);

  /// Returns a copy of [Device] with given parameters
  Device copyWith({
    FieldId? id,
    FieldId? projectID,
    String? topic,
    String? title,
    bool? jsonEnable,
    List<JsonVariable>? jsonVariables,
  }) {
    return Device(
      id: id ?? this.id,
      projectID: projectID ?? this.projectID,
      topic: topic ?? this.topic,
      title: title ?? this.title,
      jsonEnable: jsonEnable ?? this.jsonEnable,
      jsonVariables: jsonVariables ?? this.jsonVariables,
    );
  }

  @override
  List<Object> get props => [
        id,
        projectID,
        topic,
        title,
        jsonEnable,
        jsonVariables,
      ];
}
