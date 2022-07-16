import 'package:iot_api/iot_api.dart';
import 'package:test/test.dart';

void main() {
  group('Project', () {
    Project createSubject({
      int id = 0,
      String projectName = 'name',
      int customerId = 1,
      int salePersonId = 1,
      String city = 'city',
      String district = 'district',
      String ward = 'ward',
      double longitude = 100.0,
      double latitude = 100.0,
      String addressDetail = 'addressDetail',
      String? fileAttached,
      DateTime? createAt,
      int createBy = 0,
      DateTime? startDate,
      DateTime? endDate,
      DateTime? deleteAt,
      int? deleteBy,
      DateTime? updateAt,
      int? updateBy,
      String description = 'description',
    }) {
      return Project(
        id: id,
        projectName: projectName,
        customerId: customerId,
        salePersonId: salePersonId,
        city: city,
        district: district,
        ward: ward,
        longitude: longitude,
        latitude: latitude,
        fileAttached: fileAttached,
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
          1,
          1,
          'city',
          'district',
          'ward',
          100.0,
          100.0,
          'addressDetail',
          null,
          DateTime(2022, 6, 10),
          0,
          DateTime(2022, 6, 10),
          null,
          null,
          null,
          null,
          null,
          'description',
        ]);
      });
    });

    group('from Json', () {
      test('works correctly', () {
        expect(
          Project.fromJson(<String, dynamic>{
            'id': 0,
            'projectName': 'name',
            'customerId': 1,
            'salePersonId': 1,
            'city': 'city',
            'district': 'district',
            'ward': 'ward',
            'longitude': 100,
            'latitude': 100,
            'addressDetail': 'addressDetail',
            'fileAttached': null,
            'createAt': DateTime(2022, 6, 10).toIso8601String(),
            'createBy': 0,
            'startDate': DateTime(2022, 6, 10).toIso8601String(),
            'endDate': null,
            'deleteAt': null,
            'deleteBy': null,
            'updateAt': null,
            'updateBy': null,
            'description': 'description',
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
            'projectName': 'name',
            'customerId': 1,
            'salePersonId': 1,
            'city': 'city',
            'district': 'district',
            'ward': 'ward',
            'longitude': 100,
            'latitude': 100,
            'addressDetail': 'addressDetail',
            'fileAttached': null,
            'createAt': DateTime(2022, 6, 10).toIso8601String(),
            'createBy': 0,
            'startDate': DateTime(2022, 6, 10).toIso8601String(),
            'endDate': null,
            'deleteAt': null,
            'deleteBy': null,
            'updateAt': null,
            'updateBy': null,
            'description': 'description',
          }),
        );
      });
    });
  });
}
