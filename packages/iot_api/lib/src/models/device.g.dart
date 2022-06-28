// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
      id: json['id'] as int? ?? 0,
      deviceName: json['deviceName'] as String?,
      parentId: json['parentid'] as int? ?? 0,
      status: $enumDecodeNullable(_$StatusEnumMap, json['status'] as int) ??
          Status.stop,
      protocol: json['protocol'] as int? ?? 0,
      deviceType: json['devicetype'] as int? ?? 0,
      serialNumber: json['serialnumber'] as String? ?? '',
      createAt: DateTime.parse(json['createat'] as String),
      createBy: json['createby'] as int? ?? 0,
      startDate: json['startdate'] == null
          ? null
          : DateTime.parse(json['startdate'] as String),
      endDate: json['enddate'] == null
          ? null
          : DateTime.parse(json['enddate'] as String),
      deleteAt: json['deleteat'] == null
          ? null
          : DateTime.parse(json['deleteat'] as String),
      deleteBy: json['deleteby'] as int?,
      updateAt: json['updateat'] == null
          ? null
          : DateTime.parse(json['updateat'] as String),
      updateBy: json['updateby'] as int?,
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'id': instance.id,
      'deviceName': instance.deviceName,
      'parentid': instance.parentId,
      'status': _$StatusEnumMap[instance.status],
      'protocol': instance.protocol,
      'devicetype': instance.deviceType,
      'serialnumber': instance.serialNumber,
      'createat': instance.createAt.toIso8601String(),
      'createby': instance.createBy,
      'startdate': instance.startDate?.toIso8601String(),
      'enddate': instance.endDate?.toIso8601String(),
      'deleteat': instance.deleteAt?.toIso8601String(),
      'deleteby': instance.deleteBy,
      'updateat': instance.updateAt?.toIso8601String(),
      'updateby': instance.updateBy,
      'description': instance.description,
    };

const _$StatusEnumMap = {
  Status.stop: 0,
  Status.running: 1,
};
