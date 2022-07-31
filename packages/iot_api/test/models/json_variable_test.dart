// import 'package:iot_api/iot_api.dart';
// import 'package:test/test.dart';

// void main() {
//   group('JsonVariable', () {
//     JsonVariable createSubject({
//       FieldId id = 1,
//       FieldId deviceID = 2,
//       String name = 'name',
//       String jsonExtraction = 'jsonExtraction',
//     }) {
//       return JsonVariable(
//         id: id,
//         deviceID: deviceID,
//         name: name,
//         jsonExtraction: jsonExtraction,
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
//         expect(createSubject().props, <dynamic>[
//           1,
//           2,
//           'name',
//           'jsonExtraction',
//         ]);
//       });
//     });
//     group('copyWith', () {
//       test('returns same object if none arguments are provided', () {
//         expect(createSubject().copyWith(), equals(createSubject()));
//       });
//       test('returns new object with params provided', () {
//         final subjectA = createSubject(
//           id: 2,
//           deviceID: 3,
//           name: 'newname',
//           jsonExtraction: 'newjsonExtraction',
//         );
//         final subjectB = createSubject().copyWith(
//           id: 2,
//           deviceID: 3,
//           name: 'newname',
//           jsonExtraction: 'newjsonExtraction',
//         );
//         expect(subjectA, subjectB);
//       });
//     });
//     group('fromJson', () {
//       test('works correctly', () {
//         final jsonVariable = createSubject();
//         final json = <String, dynamic>{
//           'id': 1,
//           'deviceID': 2,
//           'name': 'name',
//           'jsonExtraction': 'jsonExtraction',
//         };
//         expect(JsonVariable.fromJson(json), equals(jsonVariable));
//       });
//     });
//     group('toJson', () {
//       test('works correctly', () {
//         final jsonVariable = createSubject();
//         final json = <String, dynamic>{
//           'id': 1,
//           'deviceID': 2,
//           'name': 'name',
//           'jsonExtraction': 'jsonExtraction',
//         };
//         expect(jsonVariable.toJson(), equals(json));
//       });
//     });
//   });
// }
