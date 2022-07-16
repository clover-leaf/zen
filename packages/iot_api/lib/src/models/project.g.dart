// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      id: json['id'] as int,
      projectName: json['projectName'] as String,
      customerId: json['customerId'] as int,
      salePersonId: json['salePersonId'] as int,
      city: json['city'] as String,
      district: json['district'] as String,
      ward: json['ward'] as String,
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      addressDetail: json['addressDetail'] as String,
      fileAttached: json['fileAttached'] as String?,
      createAt: DateTime.parse(json['createAt'] as String),
      createBy: json['createBy'] as int,
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
      description: json['description'] as String,
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'id': instance.id,
      'projectName': instance.projectName,
      'customerId': instance.customerId,
      'salePersonId': instance.salePersonId,
      'city': instance.city,
      'district': instance.district,
      'ward': instance.ward,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'addressDetail': instance.addressDetail,
      'fileAttached': instance.fileAttached,
      'createAt': instance.createAt.toIso8601String(),
      'createBy': instance.createBy,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'deleteAt': instance.deleteAt?.toIso8601String(),
      'deleteBy': instance.deleteBy,
      'updateAt': instance.updateAt?.toIso8601String(),
      'updateBy': instance.updateBy,
      'description': instance.description,
    };
