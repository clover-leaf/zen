// import 'package:iot_api/src/models/models.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:test/test.dart';

// class MockDevice extends Mock implements Device {}

// void main() {
//   group('ToggleTileData', () {
//     late MockDevice mockDevice;
//     setUp(() {
//       mockDevice = MockDevice();
//       when(() => mockDevice.jsonEnable).thenReturn(true);
//     });
//     ToggleTileData createSubject({
//       String? onLabel,
//       String? onValue,
//       String? offLabel,
//       String? offValue,
//       FieldId? jsonVariableID,
//     }) {
//       return ToggleTileData(
//         onLabel: onLabel,
//         onValue: onValue,
//         offLabel: offLabel,
//         offValue: offValue,
//         jsonVariableID: jsonVariableID,
//       );
//     }

//     group('constructor', () {
//       test('works correctly', () {
//         expect(createSubject, returnsNormally);
//       });
//       test('supports value equality', () {
//         expect(createSubject(), equals(createSubject()));
//       });
//       test('props are correct', () {
//         expect(createSubject().props, <dynamic>[
//           null,
//           null,
//           null,
//           null,
//           null,
//         ]);
//       });
//     });
//     group('placholder', () {
//       test('works correctly', () {
//         expect(ToggleTileData.placeholder, returnsNormally);
//       });
//       test('props are correct', () {
//         expect(
//           ToggleTileData.placeholder().props,
//           <dynamic>[null, null, null, null, null],
//         );
//       });
//     });
//     group('copyWith', () {
//       test('returns the same object if none arguments are provided', () {
//         expect(createSubject().copyWith(), equals(createSubject()));
//       });
//       test('returns a new object with params provided', () {
//         final subjectA = createSubject().copyWith(
//           onLabel: 'newonLabel',
//           onValue: 'newonValue',
//           offLabel: 'newoffLabel',
//           offValue: 'newoffValue',
//           jsonVariableID: 1,
//         );
//         final subjectB = createSubject(
//           onLabel: 'newonLabel',
//           onValue: 'newonValue',
//           offLabel: 'newoffLabel',
//           offValue: 'newoffValue',
//           jsonVariableID: 1,
//         );
//         expect(subjectA, subjectB);
//       });
//     });
//     group('isFilled', () {
//       group('json extraction is enabled', () {
//         test('returns true when every needed field are filled', () {
//           final subject = createSubject(
//             onValue: 'newonValue',
//             offValue: 'newoffValue',
//             jsonVariableID: 1,
//           );
//           expect(
//             subject.isFilled(mockDevice),
//             true,
//           );
//         });
//         test('returns false when onValue is not filled', () {
//           final subject = createSubject(
//             onValue: '',
//             offValue: '0',
//             jsonVariableID: 1,
//           );
//           expect(
//             subject.isFilled(mockDevice),
//             false,
//           );
//         });
//         test('returns false when offValue is not filled', () {
//           final subject = createSubject(
//             onValue: '1',
//             offValue: '',
//             jsonVariableID: 1,
//           );
//           expect(
//             subject.isFilled(mockDevice),
//             false,
//           );
//         });
//       });
//       group('json extraction is disabled', () {
//         setUp(() {
//           when(() => mockDevice.jsonEnable).thenReturn(false);
//         });
//         test('returns true when every needed field are filled', () {
//           final subject = createSubject(
//             onValue: 'newonValue',
//             offValue: 'newoffValue',
//             jsonVariableID: 1,
//           );
//           expect(
//             subject.isFilled(mockDevice),
//             true,
//           );
//         });
//         test('returns false when onValue is not filled', () {
//           final subject = createSubject(
//             jsonVariableID: 1,
//           );
//           expect(
//             subject.isFilled(mockDevice),
//             false,
//           );
//         });
//         test('returns false when offValue is not filled', () {
//           final subject = createSubject(
//             offValue: '',
//           );
//           expect(
//             subject.isFilled(mockDevice),
//             false,
//           );
//         });
//       });
//     });
//     group('fromJson', () {
//       test('works correctly', () {
//         final json = <String, dynamic>{
//           'type': 0,
//           'onLabel': null,
//           'onValue': null,
//           'offLabel': null,
//           'offValue': null,
//           'jsonVariableID': null,
//         };
//         final subject = createSubject();
//         expect(subject, ToggleTileData.fromJson(json));
//       });
//     });
//     group('to Json', () {
//       test('works correctly', () {
//         final json = <String, dynamic>{
//           'tileType': 0,
//           'onLabel': null,
//           'onValue': null,
//           'offLabel': null,
//           'offValue': null,
//           'jsonVariableID': null,
//         };
//         final subject = createSubject();
//         expect(subject.toJson(), json);
//       });
//     });
//   });
// }
