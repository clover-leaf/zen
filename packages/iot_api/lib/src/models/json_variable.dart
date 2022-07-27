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
    FieldId? id,
    required this.deviceID,
    required this.title,
    required this.jsonExtraction,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  /// The json variable ID
  final FieldId id;

  /// The ID of [Device] that variable is belonged to
  final FieldId deviceID;

  /// The title of variable
  final String title;

  /// The JSON extraction value
  ///
  /// more info at https://github.com/f3ath/jessie
  final String jsonExtraction;

  /// Whether every needed fields had filled or not
  bool get isFilled => title != '' && jsonExtraction != '';

  /// Deserializes the given [JsonMap] into a [JsonVariable].
  static JsonVariable fromJson(JsonMap json) => _$JsonVariableFromJson(json);

  /// Converts this [JsonVariable] into a [JsonMap].
  JsonMap toJson() => _$JsonVariableToJson(this);

  /// Returns a copy of [JsonVariable] with given parameters
  JsonVariable copyWith({
    FieldId? id,
    FieldId? deviceID,
    String? title,
    String? jsonExtraction,
  }) {
    return JsonVariable(
      id: id ?? this.id,
      deviceID: deviceID ?? this.deviceID,
      title: title ?? this.title,
      jsonExtraction: jsonExtraction ?? this.jsonExtraction,
    );
  }

  @override
  List<Object> get props => [id, deviceID, title, jsonExtraction];
}
