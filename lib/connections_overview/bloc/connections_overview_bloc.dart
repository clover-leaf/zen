// import 'dart:convert';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:iot_api/iot_api.dart';
// import 'package:iot_gateway/iot_gateway.dart';
// import 'package:iot_repository/iot_repository.dart';
// import 'package:json_path/json_path.dart';

// part 'connections_overview_event.dart';
// part 'connections_overview_state.dart';

// class ConnectionsOverviewBloc
//     extends Bloc<ConnectionsOverviewEvent, ConnectionsOverviewState> {
//   ConnectionsOverviewBloc({
//     required this.repository,
//     required GatewayClient gatewayClient,
//     required Project project,
//     required Map<FieldId, Device> deviceView,
//     required Map<FieldId, bool?> deviceStatusView,
//     required Map<FieldId, String?> subscribedTopics,
//   }) : super(
//           ConnectionsOverviewState(
//             gatewayClient: gatewayClient,
//             project: project,
//             deviceView: deviceView,
//             deviceStatusView: deviceStatusView,
//             subscribedTopics: subscribedTopics,
//           ),
//         ) {
//     on<InitializeRequested>(_onInitializeRequested);
//     on<DeviceSubscriptionRequested>(_onDeviceSubscriptionRequested);
//     on<BrokerListened>(_onBrokerListened);
//   }

//   /// The IoT repository instance
//   final IotRepository repository;

//   void _onInitializeRequested(
//     InitializeRequested event,
//     Emitter<ConnectionsOverviewState> emit,
//   ) {
//     add(const DeviceSubscriptionRequested());
//     add(const BrokerListened());
//     emit(state.copyWith(status: ConnectionsOverviewStatus.initialized));
//   }

//   /// Subcribes [Stream] of [List] of [Device]
//   Future<void> _onDeviceSubscriptionRequested(
//     DeviceSubscriptionRequested event,
//     Emitter<ConnectionsOverviewState> emit,
//   ) async {
//     await emit.forEach<List<Device>>(
//       repository.getDevices(),
//       onData: (devices) {
//         final deviceView = {for (var device in devices) device.id: device};

//         // Creates copy of deviceStatusView
//         final deviceStatusView =
//             Map<FieldId, bool?>.from(state.deviceStatusView);

//         // Creates copy of subscribedTopics
//         final subscribedTopics =
//             Map<FieldId, String?>.from(state.subscribedTopics);

//         // Finds and handles new and edited [Device]
//         final newDevice = devices.where(
//           (device) => !state.deviceView.keys.contains(device.id),
//         );
//         final editedDevice = devices.where(
//           (device) =>
//               state.deviceView.keys.contains(device.id) &&
//               device.topic != state.deviceView[device.id]?.topic,
//         );
//         for (final device in [...newDevice, ...editedDevice]) {
//           // Checks whether topic of [Device] was subscribed or not
//           if (!subscribedTopics.keys
//               .contains(formatStatusTopic(device.topic))) {
//             // Subscribes topic if gatewayClient has connected successful
//             if (state.status.isConnected) {
//               state.gatewayClient.subscribe(device.topic);
//               // we also subscribe status topic of device
//               state.gatewayClient.subscribe(formatStatusTopic(device.topic));
//             }
//             subscribedTopics[device.topic] = null;
//             subscribedTopics[formatStatusTopic(device.topic)] = null;
//             deviceStatusView[device.id] = null;
//           } else {
//             // Gets last message of this topic
//             final lastMessage =
//                 subscribedTopics[formatStatusTopic(device.topic)];
//             // Get status of [Device]
//             final status = decodeStatusPayload(payload: lastMessage);
//             deviceStatusView[device.id] = status;
//           }
//         }
//         // Finds and handles deleted [Device]
//         final deletedDevices = state.devices.where(
//           (device) => deviceView.keys.contains(device.id),
//         );
//         for (final device in deletedDevices) {
//           if (state.status.isConnected) {
//             state.gatewayClient.unsubscribe(device.topic);
//             // we also unsubscribe status topic of device
//             state.gatewayClient.unsubscribe(formatStatusTopic(device.topic));
//           }
//           subscribedTopics
//             ..remove(device.topic)
//             ..remove(formatStatusTopic(device.topic));
//           deviceStatusView.remove(device.id);
//         }
//         return state.copyWith(
//           deviceView: deviceView,
//           deviceStatusView: deviceStatusView,
//           subscribedTopics: subscribedTopics,
//         );
//       },
//     );
//   }

//   /// handles message from MQTT broker
//   Future<void> _onBrokerListened(
//     BrokerListened event,
//     Emitter<ConnectionsOverviewState> emit,
//   ) async {
//     try {
//       await emit.forEach<List<String>>(
//         repository.getPublishMsg(state.gatewayClient),
//         onData: (msg) {
//           final deviceStatusView =
//               Map<FieldId, bool?>.from(state.deviceStatusView);

//           final subscribedTopics =
//               Map<String, String?>.from(state.subscribedTopics);
//           // retrieve info from msg
//           // format [topic, payload]
//           final topic = msg[0];
//           final payload = msg[1];

//           for (final device in state.devices) {
//             // handles connection status message
//             if (topic == formatStatusTopic(device.topic)) {
//               final value = decodeStatusPayload(payload: payload);
//               subscribedTopics[formatStatusTopic(device.topic)] = payload;
//               deviceStatusView[device.id] = value;
//             }
//           }
//           return state.copyWith(
//             deviceStatusView: deviceStatusView,
//             subscribedTopics: subscribedTopics,
//           );
//         },
//       );
//     } catch (e) {
//       // emit(state.copyWith(status: TilesOverviewStatus.error));
//     }
//   }

//   /// Gets connection status topic from [Device].topic
//   String formatStatusTopic(String topic) => '$topic/<<status>>';

//   /// Decodes status payload into bool
//   bool? decodeStatusPayload({required String? payload}) {
//     if (payload != null) {
//       final status = decodeJsonPayload(
//         jsonExtraction: r'$["status"]',
//         payload: payload,
//       );
//       switch (status) {
//         case '0':
//           return false;
//         case '1':
//           return true;
//         default:
//           return null;
//       }
//     } else {
//       return null;
//     }
//   }

//   /// Decodes message payload into bool
//   String decodeJsonPayload({
//     required String jsonExtraction,
//     required String payload,
//   }) {
//     if (jsonExtraction != '') {
//       try {
//         final jsonPath = JsonPath(jsonExtraction);
//         final matchedValues = jsonPath
//             .read(jsonDecode(payload))
//             .map<String>((JsonPathMatch match) {
//           final dynamic matchValue = match.value;
//           switch (matchValue.runtimeType) {
//             case String:
//               return matchValue as String;
//             default:
//               return matchValue.toString();
//           }
//         });
//         if (matchedValues.length != 1) {
//           throw Exception('Must only one field matched!');
//         }
//         return matchedValues.first;
//       } catch (e) {
//         return '???';
//       }
//     } else {
//       return payload;
//     }
//   }
// }
