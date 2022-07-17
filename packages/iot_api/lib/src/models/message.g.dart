// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String,
      createAt: DateTime.parse(json['createAt'] as String),
      isReaded: json['isReaded'] as bool,
      alertLevel: $enumDecode(_$AlertLevelEnumMap, json['alertLevel']),
      description: json['description'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'alertLevel': _$AlertLevelEnumMap[instance.alertLevel],
      'isReaded': instance.isReaded,
      'createAt': instance.createAt.toIso8601String(),
      'description': instance.description,
    };

const _$AlertLevelEnumMap = {
  AlertLevel.low: 0,
  AlertLevel.normal: 1,
  AlertLevel.high: 2,
};
