// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:iot_api/src/models/json_map.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'generated/broker.g.dart';

@immutable
@JsonSerializable()

///
class Broker {
  ///
  Broker({
    required this.title,
    required this.url,
    required this.port,
    String? id,
    this.username,
    this.password,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  /// The broker ID
  final String id;

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

  Broker copyWith({
    String? id,
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
  String toString() {
    return 'Broker(id: $id, title: $title, url: $url,'
        ' port: $port, username: $username, password: $password)';
  }

  @override
  bool operator ==(covariant Broker other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.url == url &&
        other.port == port &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        url.hashCode ^
        port.hashCode ^
        username.hashCode ^
        password.hashCode;
  }
}
