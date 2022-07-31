// import 'package:flutter_firestore/tiles_overview/bloc/tiles_overview_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:iot_api/iot_api.dart';
// import 'package:iot_gateway/iot_gateway.dart';

// void main() {
//   group('TilesOVerviewState', () {
//     TilesOverviewState createSubject({
//       TilesOverviewStatus status = TilesOverviewStatus.initial,
//       Map<FieldId, Broker> brokerView = const {},
//       Map<FieldId, TileConfig> tileConfigView = const {},
//       Map<FieldId, GatewayClient> gatewayClientView = const {},
//       Map<FieldId, String?> tileValueView = const {},
//       Map<String, String> subscribedTopics = const {},
//     }) =>
//         TilesOverviewState(
//           status: status,
//           brokerView: brokerView,
//           mqttDeviceView: mqttDeviceView,
//           tileConfigView: tileConfigView,
//           gatewayClientView: gatewayClientView,
//           tileValueView: tileValueView,
//           subscribedTopics: subscribedTopics,
//         );
//     test('supports value equality', () {
//       expect(createSubject(), equals(createSubject()));
//     });
//     test('props are correctly', () {
//       expect(
//         createSubject().props,
//         equals([
//           TilesOverviewStatus.initial,
//           <FieldId, Broker>{},
//           <FieldId, MqttDevice>{},
//           <FieldId, TileConfig>{},
//           <FieldId, GatewayClient>{},
//           <FieldId, String?>{},
//           <FieldId, String>{},
//         ]),
//       );
//     });
//     group('copyWith', () {
//       test('returns the same object if not arguments are provided', () {
//         expect(createSubject().copyWith(), equals(createSubject()));
//       });
//       test('replaces every non-null paramenter', () {
//         expect(
//           createSubject().copyWith(
//             status: TilesOverviewStatus.success,
//             tileValueView: {'id': 'value'},
//             subscribedTopics: {'url': 'value'},
//           ),
//           equals(
//             createSubject(
//               status: TilesOverviewStatus.success,
//               tileValueView: {'id': 'value'},
//               subscribedTopics: {'url': 'value'},
//             ),
//           ),
//         );
//       });
//     });
//   });
// }
