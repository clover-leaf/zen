// import 'package:iot_api/iot_api.dart';
// import 'package:test/test.dart';

// void main() {
//   group('TileConfig', () {
//     TileConfig createSubject({
//       FieldId? id,
//       String title = 'title',
//       FieldId deviceID = 0,
//       TileType tileType = TileType.text,
//       TileData tileData = const TextTileData(
//         prefix: null,
//         postfix: null,
//         jsonVariableID: null,
//       ),
//     }) {
//       return TileConfig(
//         id: id,
//         title: title,
//         deviceID: deviceID,
//         tileType: tileType,
//         tileData: tileData,
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
//           null,
//           'title',
//           0,
//           TileType.text,
//           const TextTileData(
//             prefix: null,
//             postfix: null,
//             jsonVariableID: null,
//           ),
//         ]);
//       });
//     });
//     group('copyWith', () {
//       test('returns same object if none arguments are provided', () {
//         expect(createSubject().copyWith(), equals(createSubject()));
//       });
//       test('returns new object with params provided', () {
//         final subjectA = createSubject().copyWith(
//           id: 0,
//           title: 'newtitle',
//           deviceID: 1,
//           tileType: TileType.toggle,
//           tileData: const TextTileData(
//             prefix: 'prefix',
//             postfix: 'postfix',
//             jsonVariableID: 2,
//           ),
//         );
//         final subjectB = createSubject(
//           id: 0,
//           title: 'newtitle',
//           deviceID: 1,
//           tileType: TileType.toggle,
//           tileData: const TextTileData(
//             prefix: 'prefix',
//             postfix: 'postfix',
//             jsonVariableID: 2,
//           ),
//         );
//         expect(subjectA, subjectB);
//       });
//     });
//     group('fromJson', () {
//       test('works correctly', () {
//         final json = <String, dynamic>{
//           'id': null,
//           'title': 'title',
//           'deviceID': 0,
//           'tileType': 1,
//           'tileData': {
//             'prefix': null,
//             'postfix': null,
//             'jsonVariableID': null,
//             'tileType': 1,
//           },
//         };
//         final subject = createSubject();
//         expect(subject, TileConfig.fromJson(json));
//       });
//     });
//     group('toJson', () {
//       test('works correctly', () {
//         final json = <String, dynamic>{
//           'id': null,
//           'title': 'title',
//           'deviceID': 0,
//           'tileType': 1,
//           'tileData': {
//             'prefix': null,
//             'postfix': null,
//             'jsonVariableID': null,
//             'tileType': 1,
//           },
//         };
//         final subject = createSubject();
//         expect(subject.toJson(), json);
//       });
//     });
//   });
// }
