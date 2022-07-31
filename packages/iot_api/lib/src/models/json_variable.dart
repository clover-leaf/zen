import 'package:equatable/equatable.dart';
import 'package:iot_api/iot_api.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'generated/json_variable.g.dart';

@immutable
@JsonSerializable()

/// {@template iot_api}
/// JsonVariable models for an API providing to access json variable.
/// {@endtemplate}
class JsonVariable extends Equatable {
  /// {macro JsonVariable}
  JsonVariable({
    String? id,
    required this.deviceID,
    required this.name,
    required this.jsonExtraction,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  /// The json variable ID
  @JsonKey(name: 'id')
  final FieldId id;

  /// The ID of [Device] that variable is belonged to
  @JsonKey(name: 'device_id')
  final FieldId? deviceID;

  /// The name of variable
  @JsonKey(name: 'name')
  final String name;

  /// The JSON extraction value
  ///
  /// more info at https://github.com/f3ath/jessie
  @JsonKey(name: 'json_extraction')
  final String jsonExtraction;

  /// Whether every needed fields had filled or not
  bool get isFilled => name != '' && jsonExtraction != '';

  /// Deserializes the given [JsonMap] into a [JsonVariable].
  static JsonVariable fromJson(JsonMap json) => _$JsonVariableFromJson(json);

  /// Converts this [JsonVariable] into a [JsonMap].
  JsonMap toJson() => _$JsonVariableToJson(this);

  /// Returns a copy of [JsonVariable] with given parameters
  JsonVariable copyWith({
    FieldId? id,
    FieldId? deviceID,
    String? name,
    String? jsonExtraction,
  }) {
    return JsonVariable(
      id: id ?? this.id,
      deviceID: deviceID ?? this.deviceID,
      name: name ?? this.name,
      jsonExtraction: jsonExtraction ?? this.jsonExtraction,
    );
  }

  @override
  List<Object?> get props => [id, deviceID, name, jsonExtraction];
}
