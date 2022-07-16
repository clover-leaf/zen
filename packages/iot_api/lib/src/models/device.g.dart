// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
      id: json['id'] as int? ?? 0,
      deviceName: json['deviceName'] as String? ?? 'device name',
      parentId: json['parentId'] as int? ?? 0,
      status:
          $enumDecodeNullable(_$StatusEnumMap, json['status']) ?? Status.stop,
      protocol: $enumDecodeNullable(_$ProtocolEnumMap, json['protocol']) ??
          Protocol.mqtt,
      deviceType:
          $enumDecodeNullable(_$DeviceTypeEnumMap, json['deviceType']) ??
              DeviceType.sensor,
      serialNumber: json['serialNumber'] as String? ?? '',
      createAt: DateTime.parse(json['createAt'] as String),
      createBy: json['createBy'] as int? ?? 0,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      deleteAt: json['deleteAt'] == null
          ? null
          : DateTime.parse(json['deleteAt'] as String),
      deleteBy: json['deleteBy'] as int?,
      updateAt: json['updateAt'] == null
          ? null
          : DateTime.parse(json['updateAt'] as String),
      updateBy: json['updateBy'] as int?,
      description: json['description'] as String? ?? '',
      stationId: json['stationId'] as int?,
      projectId: json['projectId'] as int?,
      indicatorId: json['indicatorId'] as int?,
    );

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'id': instance.id,
      'deviceName': instance.deviceName,
      'parentId': instance.parentId,
      'status': _$StatusEnumMap[instance.status],
      'protocol': _$ProtocolEnumMap[instance.protocol],
      'deviceType': _$DeviceTypeEnumMap[instance.deviceType],
      'serialNumber': instance.serialNumber,
      'createAt': instance.createAt.toIso8601String(),
      'createBy': instance.createBy,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'deleteAt': instance.deleteAt?.toIso8601String(),
      'deleteBy': instance.deleteBy,
      'updateAt': instance.updateAt?.toIso8601String(),
      'updateBy': instance.updateBy,
      'description': instance.description,
      'stationId': instance.stationId,
      'projectId': instance.projectId,
      'indicatorId': instance.indicatorId,
    };

const _$StatusEnumMap = {
  Status.stop: 0,
  Status.running: 1,
};

const _$ProtocolEnumMap = {
  Protocol.http: 0,
  Protocol.mqtt: 1,
};

const _$DeviceTypeEnumMap = {
  DeviceType.sensor: 0,
  DeviceType.gadget: 1,
  DeviceType.appliance: 2,
};
