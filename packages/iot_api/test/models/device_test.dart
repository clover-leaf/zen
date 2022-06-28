import 'package:iot_api/iot_api.dart';
import 'package:test/test.dart';

void main() {
  group('Device', () {
    Device createSubject({
      int id = 0,
      String deviceName = 'name',
      int parentId = 0,
      Status status = Status.running,
      int protocol = 0,
      int deviceType = 0,
      String serialNumber = 'serialNumber',
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
      return Device(
        id: id,
        deviceName: deviceName,
        parentId: parentId,
        status: status,
        protocol: protocol,
        deviceType: deviceType,
        serialNumber: serialNumber,
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
          0,
          Status.running,
          0,
          0,
          'serialNumber',
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
          Device.fromJson(<String, dynamic>{
            'id': 0,
            'deviceName': 'name',
            'parentid': 0,
            'status': 1,
            'protocol': 0,
            'devicetype': 0,
            'serialnumber': 'serialNumber',
            'createat': DateTime(2022, 6, 10).toIso8601String(),
            'createby': 0,
            'startdate': DateTime(2022, 6, 10).toIso8601String(),
            'enddate': null,
            'deleteat': null,
            'deleteby': null,
            'updateat': null,
            'updateby': null,
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
            'deviceName': 'name',
            'parentid': 0,
            'status': 1,
            'protocol': 0,
            'devicetype': 0,
            'serialnumber': 'serialNumber',
            'createat': DateTime(2022, 6, 10).toIso8601String(),
            'createby': 0,
            'startdate': DateTime(2022, 6, 10).toIso8601String(),
            'enddate': null,
            'deleteat': null,
            'deleteby': null,
            'updateat': null,
            'updateby': null,
            'description': 'description',
          }),
        );
      });
    });
  });
}
