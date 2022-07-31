import 'package:iot_gateway/iot_gateway.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'broker.g.dart';

/// {@template iot_api}
/// Project broker for an API providing to access broker.
/// {@endtemplate}
@immutable
@JsonSerializable()
class Broker {
  /// {macro Broker}
  const Broker({
    required this.url,
    required this.port,
    this.username,
    this.password,
  });

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
    String? url,
    int? port,
    String? username,
    String? password,
  }) {
    return Broker(
      url: url ?? this.url,
      port: port ?? this.port,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}
