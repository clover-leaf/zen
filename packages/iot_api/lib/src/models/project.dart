// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:equatable/equatable.dart';
import 'package:iot_api/src/models/json_map.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'project.g.dart';

@immutable
@JsonSerializable()

/// {@template iot_api}
/// Station models for an API providing to access project.
/// {@endtemplate}
class Project extends Equatable {
  ///

  /// The unique identifier of the device
  final int id;

  /// The name of device
  final String projectName;

  /// The unique identifier of the device
  final int customerId;

  /// The unique identifier of the device
  final int salePersonId;

  /// The serial number of the device
  final String city;

  /// The date that device was created
  final String district;

  /// The date that device was created
  final String ward;

  /// The date that device was created
  final double longitude;

  /// The date that device was created
  final double latitude;

  /// The date that device was created
  final String addressDetail;

  /// The date that device was created
  final String? fileAttached;

  /// The date that device was started
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

  const Project({
    required this.id,
    required this.projectName,
    required this.customerId,
    required this.salePersonId,
    required this.city,
    required this.district,
    required this.ward,
    required this.longitude,
    required this.latitude,
    required this.addressDetail,
    this.fileAttached,
    required this.createAt,
    required this.createBy,
    this.startDate,
    this.endDate,
    this.deleteAt,
    this.deleteBy,
    this.updateAt,
    this.updateBy,
    required this.description,
  });

  
  /// Deserializes the given [JsonMap] into a [Project].
  static Project fromJson(JsonMap json) {
    return  _$ProjectFromJson(json);
  }

  /// Converts this [Project] into a [JsonMap].
  JsonMap toJson() => _$ProjectToJson(this);

  Project copyWith({
    int? id,
    String? projectName,
    int? customerId,
    int? salePersonId,
    String? city,
    String? district,
    String? ward,
    double? longitude,
    double? latitude,
    String? addressDetail,
    String? fileAttached,
    DateTime? createAt,
    int? createBy,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? deleteAt,
    int? deleteBy,
    DateTime? updateAt,
    int? updateBy,
    String? description,
  }) {
    return Project(
      id: id ?? this.id,
      projectName: projectName ?? this.projectName,
      customerId: customerId ?? this.customerId,
      salePersonId: salePersonId ?? this.salePersonId,
      city: city ?? this.city,
      district: district ?? this.district,
      ward: ward ?? this.ward,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      addressDetail: addressDetail ?? this.addressDetail,
      fileAttached: fileAttached ?? this.fileAttached,
      createAt: createAt ?? this.createAt,
      createBy: createBy ?? this.createBy,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      deleteAt: deleteAt ?? this.deleteAt,
      deleteBy: deleteBy ?? this.deleteBy,
      updateAt: updateAt ?? this.updateAt,
      updateBy: updateBy ?? this.updateBy,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      projectName,
      customerId,
      salePersonId,
      city,
      district,
      ward,
      longitude,
      latitude,
      addressDetail,
      fileAttached,
      createAt,
      createBy,
      startDate,
      endDate,
      deleteAt,
      deleteBy,
      updateAt,
      updateBy,
      description,
    ];
  }
}
