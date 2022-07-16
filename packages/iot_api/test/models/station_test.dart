import 'package:iot_api/iot_api.dart';
import 'package:test/test.dart';

void main() {
  group('Station', () {
    Station createSubject({
      int id = 0,
      String stationName = 'name',
      String phoneNumber = 'phoneNumber',
      String balance = 'balance',
      String city = 'city',
      String district = 'district',
      String ward = 'ward',
      String addressDetail = 'addressDetail',
      double longitude = 100.0,
      double latitude = 100.0,
      int qualityScore = 100,
      DateTime? expiredDate,
      DateTime? createAt,
      int createBy = 0,
      DateTime? startDate,
      DateTime? endDate,
      DateTime? deleteAt,
      int? deleteBy,
      DateTime? updateAt,
      int? updateBy,
      String description = 'description',
      int? stationId,
      int? projectId,
    }) {
      return Station(
        id: id,
        stationName: stationName,
        phoneNumber: phoneNumber,
        balance: balance,
        expiredDate: expiredDate ?? DateTime(2022, 6, 10),
        qualityScore: qualityScore,
        city: city,
        district: district,
        ward: ward,
        longitude: longitude,
        latitude: latitude,
        addressDetail: addressDetail,
        createAt: createAt ?? DateTime(2022, 6, 10),
        createBy: createBy,
        startDate: startDate ?? DateTime(2022, 6, 10),
        endDate: endDate,
        deleteAt: deleteAt,
        deleteBy: deleteBy,
        updateAt: updateAt,
        updateBy: updateBy,
        description: description,
        projectId: projectId,
      );
    }

    group('constructor', () {
      test('work correctly', () {
        expect(createSubject, returnsNormally);
      });
      test('supports value equality', () {
        expect(createSubject(), equals(createSubject()));
      });
      test('props are correct', () {
        expect(createSubject().props, <dynamic>[
          0,
          'name',
          'phoneNumber',
          'balance',
          DateTime(2022, 6, 10),
          100.0,
          'city',
          'district',
          'ward',
          100.0,
          100.0,
          'addressDetail',
          DateTime(2022, 6, 10),
          0,
          DateTime(2022, 6, 10),
          null,
          null,
          null,
          null,
          null,
          'description',
          null,
        ]);
      });
    });

    group('from Json', () {
      test('works correctly', () {
        expect(
          Station.fromJson(<String, dynamic>{
            'id': 0,
            'stationName': 'name',
            'phoneNumber': 'phoneNumber',
            'balance': 'balance',
            'city': 'city',
            'district': 'district',
            'ward': 'ward',
            'expiredDate': DateTime(2022, 6, 10).toIso8601String(),
            'qualityScore': 100,
            'longitude': 100,
            'latitude': 100,
            'addressDetail': 'addressDetail',
            'createAt': DateTime(2022, 6, 10).toIso8601String(),
            'createBy': 0,
            'startDate': DateTime(2022, 6, 10).toIso8601String(),
            'endDate': null,
            'deleteAt': null,
            'deleteBy': null,
            'updateAt': null,
            'updateBy': null,
            'description': 'description',
            'projectId': null,
          }),
          equals(
            createSubject(),
          ),
        );
      });
    });
    group('to Json', () {
      test('works correctly', () {
        expect(
          createSubject().toJson(),
          equals(<String, dynamic>{
            'id': 0,
            'stationName': 'name',
            'phoneNumber': 'phoneNumber',
            'balance': 'balance',
            'city': 'city',
            'district': 'district',
            'ward': 'ward',
            'expiredDate': DateTime(2022, 6, 10).toIso8601String(),
            'qualityScore': 100.0,
            'longitude': 100,
            'latitude': 100,
            'addressDetail': 'addressDetail',
            'createAt': DateTime(2022, 6, 10).toIso8601String(),
            'createBy': 0,
            'startDate': DateTime(2022, 6, 10).toIso8601String(),
            'endDate': null,
            'deleteAt': null,
            'deleteBy': null,
            'updateAt': null,
            'updateBy': null,
            'description': 'description',
            'projectId': null,
          }),
        );
      });
    });
  });
}
