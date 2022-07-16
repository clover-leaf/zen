import 'package:equatable/equatable.dart';
import 'package:iot_api/iot_api.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'device.g.dart';

@immutable
@JsonSerializable()

/// {@template notes_api}
/// Device models for an API providing to access device.
/// {@endtemplate}

class Device extends Equatable {
  /// {@macro note}
  const Device({
    this.id = 0,
    this.deviceName = 'device name',
    this.parentId = 0,
    this.status = Status.stop,
    this.protocol = Protocol.mqtt,
    this.deviceType = DeviceType.sensor,
    this.serialNumber = '',
    required this.createAt,
    this.createBy = 0,
    this.startDate,
    this.endDate,
    this.deleteAt,
    this.deleteBy,
    this.updateAt,
    this.updateBy,
    this.description = '',
    this.stationId,
    this.projectId,
    this.indicatorId,
  });

  /// The unique identifier of the device
  final int id;

  /// The name of device
  final String deviceName;

  /// The unique identifier of the device's parent
  final int  parentId;

  /// The unique identifier of the device's parent
  final Status status;

  /// The unique identifier of the device's parent
  final Protocol protocol;

  /// The unique identifier of the device's parent
  final DeviceType deviceType;

  /// The serial number of the device
  final String serialNumber;

  /// The date that device was created
  final DateTime createAt;

  /// The person that created device
  final int createBy;

  /// The date that device was started
  final DateTime? startDate;

  /// The date that device end
  final DateTime? endDate;

  /// The date that device was deleted
  final DateTime? deleteAt;

  /// The person that deleted device
  final int? deleteBy;

  /// The date that device was updated
  final DateTime? updateAt;

  /// The person that updated device
  final int? updateBy;

  /// The description of device
  final String description;

  /// The station id of device
  final int? stationId;

  /// The project id of device
  final int? projectId;

  /// The project id of indicator
  final int? indicatorId;

  /// Deserializes the given [JsonMap] into a [Device].
  static Device fromJson(JsonMap json) => _$DeviceFromJson(json);

  /// Converts this [Device] into a [JsonMap].
  JsonMap toJson() => _$DeviceToJson(this);

  /// Returns a copy of this device with the given values updated.
  ///
  /// {@macro note}
  Device copyWith({
    int? id,
    String? deviceName,
    int? parentId,
    Status? status,
    Protocol? protocol,
    DeviceType? deviceType,
    String? serialNumber,
    DateTime? createAt,
    int? createBy,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? deleteAt,
    int? deleteBy,
    DateTime? updateAt,
    int? updateBy,
    String? description,
    int? stationId,
    int? projectId,
    int? indicatorId,
  }) {
    return Device(
      id: id ?? this.id,
      deviceName: deviceName ?? this.deviceName,
      parentId: parentId ?? this.parentId,
      status: status ?? this.status,
      protocol: protocol ?? this.protocol,
      deviceType: deviceType ?? this.deviceType,
      serialNumber: serialNumber ?? this.serialNumber,
      createAt: createAt ?? this.createAt,
      createBy: createBy ?? this.createBy,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      deleteAt: deleteAt ?? this.deleteAt,
      deleteBy: deleteBy ?? this.deleteBy,
      updateAt: updateAt ?? this.updateAt,
      updateBy: updateBy ?? this.updateBy,
      description: description ?? this.description,
      stationId: stationId ?? this.stationId,
      projectId: projectId ?? this.projectId,
      indicatorId: indicatorId ?? this.indicatorId,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      deviceName,
      parentId,
      status,
      protocol,
      deviceType,
      serialNumber,
      createAt,
      createBy,
      startDate,
      endDate,
      deleteAt,
      deleteBy,
      updateAt,
      updateBy,
      description,
      stationId,
      projectId,
      indicatorId,
    ];
  }
}
