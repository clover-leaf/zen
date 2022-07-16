// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Station _$StationFromJson(Map<String, dynamic> json) => Station(
      id: json['id'] as int,
      stationName: json['stationName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      balance: json['balance'] as String,
      expiredDate: DateTime.parse(json['expiredDate'] as String),
      qualityScore: json['qualityScore'] as int,
      city: json['city'] as String,
      district: json['district'] as String,
      ward: json['ward'] as String,
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      addressDetail: json['addressDetail'] as String,
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
      projectId: json['projectId'] as int?,
    );

Map<String, dynamic> _$StationToJson(Station instance) => <String, dynamic>{
      'id': instance.id,
      'stationName': instance.stationName,
      'phoneNumber': instance.phoneNumber,
      'balance': instance.balance,
      'expiredDate': instance.expiredDate.toIso8601String(),
      'qualityScore': instance.qualityScore,
      'city': instance.city,
      'district': instance.district,
      'ward': instance.ward,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'addressDetail': instance.addressDetail,
      'createAt': instance.createAt.toIso8601String(),
      'createBy': instance.createBy,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'deleteAt': instance.deleteAt?.toIso8601String(),
      'deleteBy': instance.deleteBy,
      'updateAt': instance.updateAt?.toIso8601String(),
      'updateBy': instance.updateBy,
      'description': instance.description,
      'projectId': instance.projectId,
    };
