// part of 'connections_overview_bloc.dart';

// enum ConnectionsOverviewStatus {
//   initializing,
//   initialized,
//   connected,
// }

// extension ConnectionsOverviewStatusX on ConnectionsOverviewStatus {
//   bool get isInitializing => this == ConnectionsOverviewStatus.initializing;

//   bool get isInitialized => this == ConnectionsOverviewStatus.initialized;

//   bool get isConnected => this == ConnectionsOverviewStatus.connected;
// }

// class ConnectionsOverviewState extends Equatable {
//   ConnectionsOverviewState({
//     this.status = ConnectionsOverviewStatus.initializing,
//     required this.gatewayClient,
//     required this.project,
//     required this.deviceView,
//     required this.deviceStatusView,
//     required this.subscribedTopics,
//   });

//   /// The status of state
//   final ConnectionsOverviewStatus status;

//   /// The only [GatewayClient] of page
//   final GatewayClient gatewayClient;

//   /// The showed [Project]
//   final Project project;

//   /// The map of [FieldId] of [Device] and it
//   ///
//   /// <Device.id, Device>
//   final Map<FieldId, Device> deviceView;

//   /// The list of [Device]
//   late final List<Device> devices = deviceView.values.toList();

//   /// The map of [Device] with its connection status
//   ///
//   /// There is a bijection from deviceView to deviceStatusView
//   /// When deviceView changes, it also changes
//   /// Beside, it only change value of pair when coming payload listened,
//   /// but never change its size in this case
//   final Map<FieldId, bool?> deviceStatusView;

//   /// The map of subscribed topic and its last message
//   ///
//   /// There is a bijection from deviceView to subscribedTopic,
//   /// When deviceView changes, it also changes
//   /// Note: message mean raw payload that not
//   /// extracted JSON yet (if JSON is enabled)
//   final Map<String, String?> subscribedTopics;

//   ConnectionsOverviewState copyWith({
//     ConnectionsOverviewStatus? status,
//     GatewayClient? gatewayClient,
//     Project? project,
//     Map<FieldId, Project>? projectView,
//     Map<FieldId, Device>? deviceView,
//     Map<FieldId, bool?>? deviceStatusView,
//     Map<String, String?>? subscribedTopics,
//   }) =>
//       ConnectionsOverviewState(
//         status: status ?? this.status,
//         gatewayClient: gatewayClient ?? this.gatewayClient,
//         project: project ?? this.project,
//         deviceView: deviceView ?? this.deviceView,
//         deviceStatusView: deviceStatusView ?? this.deviceStatusView,
//         subscribedTopics: subscribedTopics ?? this.subscribedTopics,
//       );

//   @override
//   List<Object> get props => [
//         status,
//         gatewayClient,
//         project,
//         deviceView,
//         deviceStatusView,
//         subscribedTopics,
//       ];
// }
