import 'package:iot_api/iot_api.dart';
import 'package:test/test.dart';

void main() {
  group('Device', () {
    Device createSubject({
      FieldId? id,
      FieldId projectID = 'project_id',
      String key = 'key',
      String name = 'name',
      String? description,
      bool jsonEnable = false,
      List<JsonVariable> jsonVariables = const [],
      DateTime? createdAt,
      FieldId? createdBy,
      DateTime? updatedAt,
      FieldId? updatedBy,
    }) {
      return Device(
        id: id,
        projectID: projectID,
        key: key,
        name: name,
        description: description,
        jsonEnable: jsonEnable,
        jsonVariables: jsonVariables,
        createdAt: createdAt,
        createdBy: createdBy,
        updatedAt: updatedAt,
        updatedBy: updatedBy,
      );
    }

    group('Constructor', () {
      test('works correctly', () {
        expect(createSubject, returnsNormally);
      });
      test('supports value equality', () {
        final subjectA = createSubject();
        final subjectB = createSubject(id: subjectA.id);
        expect(subjectA, subjectB);
      });
      test('props are correct', () {
        final props = <dynamic>[
          anything,
          'project_id',
          'key',
          'name',
          null,
          false,
          <JsonVariable>[],
          null,
          null,
          null,
          null,
        ];
        expect(createSubject().props, props);
      });
    });
    group('copyWith', () {
      test('returns same object if none arguments are provided', () {
        final subjectA = createSubject();
        final subjectB = subjectA.copyWith();
        expect(subjectA, subjectB);
      });
      test('returns new object with params provided', () {
        final subjectA = createSubject(
          key: 'newKey',
          name: 'newname',
          jsonEnable: true,
          jsonVariables: [],
          createdAt: DateTime(2022, 10, 6),
          createdBy: 'createdBy',
        );
        final subjectB = createSubject().copyWith(
          id: subjectA.id,
          key: 'newKey',
          name: 'newname',
          jsonEnable: true,
          jsonVariables: [],
          createdAt: DateTime(2022, 10, 6),
          createdBy: 'createdBy',
        );
        expect(subjectA, subjectB);
      });
    });
    group('fromJson', () {
      test('works correctly', () {
        final subject = createSubject();
        final json = <String, dynamic>{
          'id': subject.id,
          'project_id': 'project_id',
          'key': 'key',
          'name': 'name',
          'description': null,
          'json_enable': false,
          'json_variables': <JsonVariable>[],
          'created_at': null,
          'created_by': null,
          'updated_at': null,
          'updated_by': null,
        };
        expect(Device.fromJson(json), subject);
      });

      test('work correctly with data', () {
        final subject = createSubject(
          id: '611521a6-b964-4773-bb39-7b298af7ae7b',
          projectID: 'd7cfd791-5d7d-4c80-b313-9b5991cdc35f',
          key: 'sleep',
          name: 'sleep edited',
          createdAt: DateTime.parse('2022-07-31T08:14:08'),
          createdBy: '8e9668a4-c08d-4622-b3b0-0b5f8fea95c1',
          updatedAt: DateTime.parse('2022-07-31T08:14:08'),
          updatedBy: '8e9668a4-c08d-4622-b3b0-0b5f8fea95c1',
        );
        final json = <String, dynamic>{
          'id': '611521a6-b964-4773-bb39-7b298af7ae7b',
          'project_id': 'd7cfd791-5d7d-4c80-b313-9b5991cdc35f',
          'key': 'sleep',
          'name': 'sleep edited',
          'description': null,
          'json_enable': false,
          'json_variables': <JsonVariable>[],
          'created_at': '2022-07-31T08:14:08',
          'created_by': '8e9668a4-c08d-4622-b3b0-0b5f8fea95c1',
          'updated_at': '2022-07-31T08:14:08',
          'updated_by': '8e9668a4-c08d-4622-b3b0-0b5f8fea95c1',
        };
        expect(subject.toJson(), json);
      });
    });
    group('toJson', () {
      test('works correctly', () {
        final subject = createSubject();
        final json = <String, dynamic>{
          'id': subject.id,
          'project_id': 'project_id',
          'key': 'key',
          'name': 'name',
          'description': null,
          'json_enable': false,
          'json_variables': <JsonVariable>[],
          'created_at': null,
          'created_by': null,
          'updated_at': null,
          'updated_by': null,
        };
        expect(subject, Device.fromJson(json));
      });

      test('work correctly with data', () {
        final subject = createSubject(
          id: '611521a6-b964-4773-bb39-7b298af7ae7b',
          projectID: 'd7cfd791-5d7d-4c80-b313-9b5991cdc35f',
          key: 'sleep',
          name: 'sleep edited',
          createdAt: DateTime.parse('2022-07-31T08:14:08'),
          createdBy: '8e9668a4-c08d-4622-b3b0-0b5f8fea95c1',
          updatedAt: DateTime.parse('2022-07-31T08:14:08'),
          updatedBy: '8e9668a4-c08d-4622-b3b0-0b5f8fea95c1',
        );
        final json = <String, dynamic>{
          'id': '611521a6-b964-4773-bb39-7b298af7ae7b',
          'project_id': 'd7cfd791-5d7d-4c80-b313-9b5991cdc35f',
          'key': 'sleep',
          'name': 'sleep edited',
          'description': null,
          'json_enable': false,
          'json_variables': <JsonVariable>[],
          'created_at': '2022-07-31T08:14:08',
          'created_by': '8e9668a4-c08d-4622-b3b0-0b5f8fea95c1',
          'updated_at': '2022-07-31T08:14:08',
          'updated_by': '8e9668a4-c08d-4622-b3b0-0b5f8fea95c1',
        };
        expect(subject.toJson(), json);
      });
    });
  });
}
