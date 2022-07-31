// import 'package:iot_api/iot_api.dart';
// import 'package:test/test.dart';

// void main() {
//   group('Project', () {
//     Project createSubject({
//       FieldId? id,
//       String? key,
//       String name = 'name',
//       String? description,
//       DateTime? createAt,
//       FieldId? createBy,
//       DateTime? updateAt,
//       FieldId? updateBy,
//     }) {
//       return Project(
//         id: id,
//         key: key,
//         name: name,
//         description: description,
//         createAt: createAt,
//         createBy: createBy,
//         updateAt: updateAt,
//         updateBy: updateBy,
//       );
//     }

//     group('Constructor', () {
//       test('works correctly', () {
//         expect(createSubject, returnsNormally);
//       });
//       test('supports value equality', () {
//         final subjectA = createSubject();
//         final subjectB = createSubject();
//         expect(subjectA, subjectB);
//       });
//       test('props are correct', () {
//         expect(createSubject().props, <dynamic>[
//           null,
//           null,
//           'name',
//           null,
//           null,
//           null,
//           null,
//           null,
//         ]);
//       });
//     });
//     group('copyWith', () {
//       test('returns the same object if none arguments are provided', () {
//         expect(createSubject().copyWith(), equals(createSubject()));
//       });
//       test('returns a new object with params provided', () {
//         final subjectA = createSubject(
//           id: 1,
//           key: 'key',
//           description: 'description',
//           createAt: DateTime(2022, 6, 10),
//           createBy: 1,
//           updateAt: DateTime(2022, 6, 10),
//           updateBy: 1,
//         );
//         final subjectB = createSubject().copyWith(
//           id: 1,
//           key: 'key',
//           description: 'description',
//           createAt: DateTime(2022, 6, 10),
//           createBy: 1,
//           updateAt: DateTime(2022, 6, 10),
//           updateBy: 1,
//         );
//         expect(subjectA, subjectB);
//       });
//     });
//     group('fromJson', () {
//       test('works correctly', () {
//         final json = <String, dynamic>{
//           'id': null,
//           'key': null,
//           'name': 'name',
//           'description': null,
//           'createAt': null,
//           'createBy': null,
//           'updateAt': null,
//           'updateBy': null,
//         };
//         final subject = createSubject();
//         expect(subject, Project.fromJson(json));
//       });
//     });
//     group('toJson', () {
//       test('works correctly', () {
//         final json = <String, dynamic>{
//           'id': null,
//           'key': null,
//           'name': 'name',
//           'description': null,
//           'createAt': null,
//           'createBy': null,
//           'updateAt': null,
//           'updateBy': null,
//         };
//         final subject = createSubject();
//         expect(subject.toJson(), json);
//       });
//     });
//   });
// }
