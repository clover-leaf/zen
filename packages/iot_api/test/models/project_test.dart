import 'package:iot_api/iot_api.dart';
import 'package:test/test.dart';

void main() {
  group('Project', () {
    Project createSubject({
      FieldId? id,
      String key = 'key',
      String name = 'name',
      String? description,
      DateTime? createdAt,
      FieldId? createdBy,
      DateTime? updatedAt,
      FieldId? updatedBy,
    }) {
      return Project(
        id: id,
        key: key,
        name: name,
        description: description,
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
          'key',
          'name',
          null,
          null,
          null,
          null,
          null
        ];
        expect(createSubject().props, props);
      });
    });
    group('copyWith', () {
      test('returns the same object if none arguments are provided', () {
        final subjectA = createSubject();
        final subjectB = subjectA.copyWith();
        expect(subjectA, subjectB);
      });
      test('returns a new object with params provided', () {
        final subjectA = createSubject(
          id: 'id',
          description: 'description',
          createdAt: DateTime(2022, 6, 10),
          createdBy: 'createdBy',
          updatedAt: DateTime(2022, 6, 10),
          updatedBy: 'updatedBy',
        );
        final subjectB = createSubject().copyWith(
          id: 'id',
          key: 'key',
          description: 'description',
          createdAt: DateTime(2022, 6, 10),
          createdBy: 'createdBy',
          updatedAt: DateTime(2022, 6, 10),
          updatedBy: 'updatedBy',
        );
        expect(subjectA, subjectB);
      });
    });
    group('fromJson', () {
      test('works correctly', () {
        final subject = createSubject();
        final json = <String, dynamic>{
          'id': subject.id,
          'key': 'key',
          'name': 'name',
          'description': null,
          'created_at': null,
          'created_by': null,
          'updated_at': null,
          'updated_by': null,
        };
        expect(subject, Project.fromJson(json));
      });
      test('works correctly with data', () {
        final subject = createSubject(
          key: 'test',
          name: 'test',
          createdAt: DateTime.parse('2022-07-31T08:14:08'),
          createdBy: '8e9668a4-c08d-4622-b3b0-0b5f8fea95c1',
          updatedAt: DateTime.parse('2022-07-31T08:14:08'),
          updatedBy: '8e9668a4-c08d-4622-b3b0-0b5f8fea95c1',
        );
        final json = <String, dynamic>{
          'id': subject.id,
          'created_at': '2022-07-31T08:14:08',
          'updated_at': '2022-07-31T08:14:08',
          'key': 'test',
          'name': 'test',
          'updated_by': '8e9668a4-c08d-4622-b3b0-0b5f8fea95c1',
          'created_by': '8e9668a4-c08d-4622-b3b0-0b5f8fea95c1',
          'description': null
        };
        expect(subject, Project.fromJson(json));
      });
    });
    group('toJson', () {
      test('works correctly', () {
        final subject = createSubject();
        final json = <String, dynamic>{
          'id': subject.id,
          'key': 'key',
          'name': 'name',
          'description': null,
          'created_at': null,
          'created_by': null,
          'updated_at': null,
          'updated_by': null,
        };
        expect(subject.toJson(), json);
      });
      test('work correctly with data', () {
        final subject = createSubject(
          key: 'test',
          name: 'test',
          createdAt: DateTime.parse('2022-07-31T08:14:08'),
          createdBy: '8e9668a4-c08d-4622-b3b0-0b5f8fea95c1',
          updatedAt: DateTime.parse('2022-07-31T08:14:08'),
          updatedBy: '8e9668a4-c08d-4622-b3b0-0b5f8fea95c1',
        );
        final json = <String, dynamic>{
          'id': subject.id,
          'created_at': '2022-07-31T08:14:08',
          'updated_at': '2022-07-31T08:14:08',
          'key': 'test',
          'name': 'test',
          'updated_by': '8e9668a4-c08d-4622-b3b0-0b5f8fea95c1',
          'created_by': '8e9668a4-c08d-4622-b3b0-0b5f8fea95c1',
          'description': null
        };
        expect(subject.toJson(), json);
      });
    });
  });
}
