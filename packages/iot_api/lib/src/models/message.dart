import 'package:equatable/equatable.dart';
import 'package:iot_api/iot_api.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'message.g.dart';

@immutable
@JsonSerializable()

/// {@template iot_api}
/// Message models for an API providing to access Message.
/// {@endtemplate}

class Message extends Equatable {
  /// {@macro message}
  const Message({
    this.id = 0,
    required this.title,
    required this.createAt,
    required this.isReaded,
    required this.alertLevel,
    required this.description,
  });

  /// The unique identifier of the device
  final int id;

  /// The name of device
  final String title;

  /// The name of device
  final AlertLevel alertLevel;

  /// The unique identifier of the device's parent
  final bool isReaded;

  /// The date that device was created
  final DateTime createAt;

  /// The description of device
  final String description;


  /// Deserializes the given [JsonMap] into a [Message].
  static Message fromJson(JsonMap json) => _$MessageFromJson(json);

  /// Converts this [Message] into a [JsonMap].
  JsonMap toJson() => _$MessageToJson(this);

  /// Returns a copy of this message with the given values updated.
  ///
  /// {@macro message}
  Message copyWith({
    int? id,
    String? title,
    AlertLevel? alertLevel,
    bool? isReaded,
    DateTime? createAt,
    String? description,
  }) {
    return Message(
      id: id ?? this.id,
      title: title ?? this.title,
      alertLevel: alertLevel ?? this.alertLevel,
      isReaded: isReaded ?? this.isReaded,
      createAt: createAt ?? this.createAt,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      title,
      alertLevel,
      isReaded,
      createAt,
      description,
    ];
  }
}
