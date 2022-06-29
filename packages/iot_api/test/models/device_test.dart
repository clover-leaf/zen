import 'package:iot_api/iot_api.dart';
import 'package:test/test.dart';

void main() {
  group('Device', () {
    Device createSubject({
      int id = 0,
      String deviceName = 'name',
      int parentId = 0,
      Status status = Status.running,
      Protocol protocol = Protocol.mqtt,
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
      int? stationId,
      int? projectId,
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
        stationId: stationId,
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
          0,
          Status.running,
          Protocol.mqtt,
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
          null,
          null,
        ]);
      });
    });

    group('from Json', () {
      test('works correctly', () {
        expect(
          Device.fromJson(<String, dynamic>{
            'id': 0,
            'deviceName': 'name',
            'parentId': 0,
            'status': 1,
            'protocol': 1,
            'deviceType': 0,
            'serialNumber': 'serialNumber',
            'createAt': DateTime(2022, 6, 10).toIso8601String(),
            'createBy': 0,
            'startDate': DateTime(2022, 6, 10).toIso8601String(),
            'endDate': null,
            'deleteAt': null,
            'deleteBy': null,
            'updateAt': null,
            'updateBy': null,
            'description': 'description',
            'stationId': null,
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
            'deviceName': 'name',
            'parentId': 0,
            'status': 1,
            'protocol': 1,
            'deviceType': 0,
            'serialNumber': 'serialNumber',
            'createAt': DateTime(2022, 6, 10).toIso8601String(),
            'createBy': 0,
            'startDate': DateTime(2022, 6, 10).toIso8601String(),
            'endDate': null,
            'deleteAt': null,
            'deleteBy': null,
            'updateAt': null,
            'updateBy': null,
            'description': 'description',
            'stationId': null,
            'projectId': null,
          }),
        );
      });
    });
  });
}
