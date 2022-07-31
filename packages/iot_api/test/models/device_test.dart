// import 'package:iot_api/iot_api.dart';
// import 'package:test/test.dart';

// void main() {
//   group('Device', () {
//     Device createSubject({
//       FieldId? id,
//       FieldId projectID = 0,
//       String? key,
//       String name = 'name',
//       String? description,
//       bool jsonEnable = false,
//       List<JsonVariable> attributes = const [],
//       DateTime? createAt,
//       FieldId? createBy,
//       DateTime? updateAt,
//       FieldId? updateBy,
//     }) {
//       return Device(
//         id: id,
//         projectID: projectID,
//         key: key,
//         name: name,
//         description: description,
//         jsonEnable: jsonEnable,
//         attributes: attributes,
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
//         expect(createSubject(), equals(createSubject()));
//       });
//       test('props are correct', () {
//         final props = <dynamic>[
//           null,
//           0,
//           null,
//           'name',
//           null,
//           false,
//           <JsonVariable>[],
//           null,
//           null,
//           null,
//           null,
//         ];
//         expect(createSubject().props, props);
//       });
//     });
//     group('copyWith', () {
//       test('returns same object if none arguments are provided', () {
//         expect(createSubject().copyWith(), equals(createSubject()));
//       });
//       test('returns new object with params provided', () {
//         final subjectA = createSubject().copyWith(
//           id: 1,
//           key: 'key',
//           name: 'newname',
//           jsonEnable: true,
//           attributes: [],
//           createAt: DateTime(2022, 10, 6),
//           createBy: 1,
//         );
//         final subjectB = createSubject(
//           id: 1,
//           key: 'key',
//           name: 'newname',
//           jsonEnable: true,
//           attributes: [],
//           createAt: DateTime(2022, 10, 6),
//           createBy: 1,
//         );
//         expect(subjectA, subjectB);
//       });
//     });
//     group('fromJson', () {
//       test('works correctly', () {
//         final json = <String, dynamic>{
//           'id': null,
//           'projectID': 0,
//           'key': null,
//           'name': 'name',
//           'jsonEnable': false,
//           'attributes': <JsonVariable>[],
//           'createAt': null,
//           'createBy': null,
//           'updateAt': null,
//           'updateBy': null,
//         };
//         final subject = createSubject();
//         expect(Device.fromJson(json), equals(subject));
//       });
//     });
//     group('toJson', () {
//       test('works correctly', () {
//         final json = <String, dynamic>{
//           'id': null,
//           'projectID': 0,
//           'key': null,
//           'name': 'name',
//           'jsonEnable': false,
//           'attributes': <JsonVariable>[],
//           'createAt': null,
//           'createBy': null,
//           'updateAt': null,
//           'updateBy': null,
//         };
//         final subject = createSubject();
//         expect(subject, Device.fromJson(json));
//       });
//     });
//   });
// }
