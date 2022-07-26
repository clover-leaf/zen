import 'package:equatable/equatable.dart';
import 'package:iot_api/src/models/typedef/typedef.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'generated/broker.g.dart';

@immutable
@JsonSerializable()

/// {@template iot_api}
/// Project broker for an API providing to access broker.
/// {@endtemplate}
class Broker extends Equatable {
  /// {macro Broker}
  Broker({
    FieldId? id,
    required this.title,
    required this.url,
    required this.port,
    this.username,
    this.password,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  /// The broker ID
  final FieldId id;

  /// The title of broker
  final String title;

  /// The url of broker
  final String url;

  /// The port of broker
  final int port;

  /// The username when connect to broker
  final String? username;

  /// The password when connect to broker
  final String? password;

  /// Deserializes the given [JsonMap] into a [Broker].
  static Broker fromJson(JsonMap json) => _$BrokerFromJson(json);

  /// Converts this [Broker] into a [JsonMap].
  JsonMap toJson() => _$BrokerToJson(this);

  /// Returns a copy of [Broker] with given parameters
  Broker copyWith({
    FieldId? id,
    String? title,
    String? url,
    int? port,
    String? username,
    String? password,
  }) {
    return Broker(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      port: port ?? this.port,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [id, title, url, port, username, password];
}
