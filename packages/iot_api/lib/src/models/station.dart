// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'package:equatable/equatable.dart';
import 'package:iot_api/iot_api.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'station.g.dart';

@immutable
@JsonSerializable()
/// {@template iot_api}
/// Station models for an API providing to access device.
/// {@endtemplate}
class Station extends Equatable {
  ///

  /// The unique identifier of the device
  final int id;

  /// The name of device
  final String stationName;

  /// The unique identifier of the device's parent
  final String phoneNumber;

  /// The unique identifier of the device's parent
  final String balance;

  /// The unique identifier of the device's parent
  final DateTime expiredDate;

  /// The unique identifier of the device's parent
  final int qualityScore;

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

  /// The project id of device
  final int? projectId;
  const Station({
    required this.id,
    required this.stationName,
    required this.phoneNumber,
    required this.balance,
    required this.expiredDate,
    required this.qualityScore,
    required this.city,
    required this.district,
    required this.ward,
    required this.longitude,
    required this.latitude,
    required this.addressDetail,
    required this.createAt,
    required this.createBy,
    this.startDate,
    this.endDate,
    this.deleteAt,
    this.deleteBy,
    this.updateAt,
    this.updateBy,
    required this.description,
    this.projectId,
  });
  // /// The description of device
  // final Map<String, String> trackingData;

  /// Deserializes the given [JsonMap] into a [Station].
  static Station fromJson(JsonMap json) => _$StationFromJson(json);

  /// Converts this [Station] into a [JsonMap].
  JsonMap toJson() => _$StationToJson(this);

  // /// Returns a copy of this device with the given values updated.
  // ///
  // /// {@macro note}
  Station copyWith({
    int? id,
    String? stationName,
    String? phoneNumber,
    String? balance,
    DateTime? expiredDate,
    int? qualityScore,
    String? city,
    String? district,
    String? ward,
    double? longitude,
    double? latitude,
    String? addressDetail,
    DateTime? createAt,
    int? createBy,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? deleteAt,
    int? deleteBy,
    DateTime? updateAt,
    int? updateBy,
    String? description,
    int? projectId,
  }) {
    return Station(
      id: id ?? this.id,
      stationName: stationName ?? this.stationName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      balance: balance ?? this.balance,
      expiredDate: expiredDate ?? this.expiredDate,
      qualityScore: qualityScore ?? this.qualityScore,
      city: city ?? this.city,
      district: district ?? this.district,
      ward: ward ?? this.ward,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      addressDetail: addressDetail ?? this.addressDetail,
      createAt: createAt ?? this.createAt,
      createBy: createBy ?? this.createBy,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      deleteAt: deleteAt ?? this.deleteAt,
      deleteBy: deleteBy ?? this.deleteBy,
      updateAt: updateAt ?? this.updateAt,
      updateBy: updateBy ?? this.updateBy,
      description: description ?? this.description,
      projectId: projectId ?? this.projectId,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      stationName,
      phoneNumber,
      balance,
      expiredDate,
      qualityScore,
      city,
      district,
      ward,
      longitude,
      latitude,
      addressDetail,
      createAt,
      createBy,
      startDate,
      endDate,
      deleteAt,
      deleteBy,
      updateAt,
      updateBy,
      description,
      projectId,
    ];
  }
}
