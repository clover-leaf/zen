// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:iot_api/iot_api.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'generated/mqtt_device.g.dart';

@immutable
@JsonSerializable()

///
class MqttDevice {
  ///
  MqttDevice({
    String? id,
    required this.brokerID,
    required this.topic,
    required this.title,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  /// The device ID
  final String id;

  /// The broker of client
  final String brokerID;

  /// The name of topic on broker
  final String topic;

  /// The title of device
  final String title;

  /// Deserializes the given [JsonMap] into a [MqttDevice].
  static MqttDevice fromJson(JsonMap json) => _$MqttDeviceFromJson(json);

  /// Converts this [MqttDevice] into a [JsonMap].
  JsonMap toJson() => _$MqttDeviceToJson(this);

  MqttDevice copyWith({
    String? id,
    String? brokerID,
    String? topic,
    String? title,
  }) {
    return MqttDevice(
      id: id ?? this.id,
      brokerID: brokerID ?? this.brokerID,
      topic: topic ?? this.topic,
      title: title ?? this.title,
    );
  }

  @override
  String toString() {
    return 'MqttDevice(id: $id, brokerID: $brokerID,'
        ' topic: $topic, title: $title)';
  }

  @override
  bool operator ==(covariant MqttDevice other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.brokerID == brokerID &&
        other.topic == topic &&
        other.title == title;
  }

  @override
  int get hashCode {
    return id.hashCode ^ brokerID.hashCode ^ topic.hashCode ^ title.hashCode;
  }
}
