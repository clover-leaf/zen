// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_firestore/common/constants/constants.dart';
// import 'package:flutter_firestore/connections_overview/connections_overview.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:iot_api/iot_api.dart';
// import 'package:iot_gateway/iot_gateway.dart';
// import 'package:iot_repository/iot_repository.dart';

// class ConnectionsOverviewPage extends StatelessWidget {
//   const ConnectionsOverviewPage({super.key});

//   static Route route({
//     required IotRepository repository,
//     required GatewayClient gatewayClient,
//     required Project project,
//     required Map<FieldId, Device> deviceView,
//     required Map<FieldId, bool?> deviceStatusView,
//     required Map<String, String?> subscribedTopics,
//   }) {
//     return PageRouteBuilder<void>(
//       pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
//         create: (_) => ConnectionsOverviewBloc(
//           repository: repository,
//           gatewayClient: gatewayClient,
//           project: project,
//           deviceView: deviceView,
//           deviceStatusView: deviceStatusView,
//           subscribedTopics: subscribedTopics,
//         )..add(const InitializeRequested()),
//         child: const ConnectionsOverviewPage(),
//       ),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = Offset(0, 1);
//         const end = Offset.zero;
//         const curve = Curves.ease;
//         final tween =
//             Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//         return SlideTransition(
//           position: animation.drive(tween),
//           child: child,
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const ConnectionsOverviewView();
//   }
// }

// class ConnectionsOverviewView extends StatelessWidget {
//   const ConnectionsOverviewView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final state = context.watch<ConnectionsOverviewBloc>().state;
//     final status = state.status;
//     final textTheme = Theme.of(context).textTheme;

//     return Container(
//       padding: EdgeInsets.fromLTRB(
//         Space.contentPaddingHorizontal.value,
//         Space.contentPaddingTop.value,
//         Space.contentPaddingHorizontal.value,
//         24,
//       ),
//       decoration: const BoxDecoration(
//         color: Color(0xffffffff),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const _Headline(),
//           if (devices.isEmpty)
//             const Expanded(
//               child: MyEmptyPage(
//                 message: 'There are no devices.'
//                     ' \nCreate a new ones to start!',
//               ),
//             )
//           else
//             _DeviceList(
//               devices: showedDevices,
//               deviceStatusView: deviceStatusView,
//             )
//         ],
//       ),
//     );
//   }
// }

// class _Headline extends StatelessWidget {
//   const _Headline();


//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 32),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               GestureDetector(
//                 behavior: HitTestBehavior.opaque,
//                 onTap: () => Navigator.of(context).pop(),
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                     right: 12,
//                   ),
//                   child: SvgPicture.asset(
//                     MyIcon.leftButton.getPath(),
//                     color: const Color(0xff757575),
//                   ),
//                 ),
//               ),
//               Text(
//                 'Connection status',
//                 style: textTheme.headlineSmall,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _DeviceList extends StatelessWidget {
//   const _DeviceList({
//     required this.devices,
//     required this.deviceStatusView,
//   });

//   final List<Device> devices;
//   final Map<FieldId, bool?> deviceStatusView;

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     final titleStyle = textTheme.titleMedium!.copyWith(
//       fontWeight: FontWeight.w500,
//       letterSpacing: 0.3,
//     );
//     final subtitleStyle = textTheme.titleSmall!.copyWith(
//       color: const Color(0xff757575),
//       letterSpacing: 0.5,
//     );

//     return Expanded(
//       child: ListView.separated(
//         separatorBuilder: (_, __) => Divider(
//           thickness: Space.globalBorderWidth.value,
//           height: 48,
//         ),
//         itemBuilder: (context, index) {
//           final device = devices[index];
//           final status = deviceStatusView[device.id];
//           return DeviceLine(
//             title: device.title,
//             titleStyle: titleStyle,
//             subtitle: device.topic,
//             subtitleStyle: subtitleStyle,
//             status: status,
//           );
//         },
//         itemCount: devices.length,
//       ),
//     );
//   }
// }

// class DeviceLine extends StatelessWidget {
//   const DeviceLine({
//     super.key,
//     required this.title,
//     required this.titleStyle,
//     required this.subtitle,
//     required this.subtitleStyle,
//     required this.status,
//   });

//   final String title;
//   final TextStyle titleStyle;
//   final String subtitle;
//   final TextStyle subtitleStyle;
//   final bool? status;

//   @override
//   Widget build(BuildContext context) {
//     late String statusLabel;
//     late Color statusColor;
//     late Color bgColor;
//     switch (status) {
//       case true:
//         statusLabel = 'connected';
//         statusColor = const Color(0xff197741);
//         bgColor = const Color(0xffe3fcec);
//         break;
//       case false:
//         statusLabel = 'disconnected';
//         statusColor = const Color(0xff881b1b);
//         bgColor = const Color(0xfff9e5e6);
//         break;
//       default:
//         statusLabel = 'unknown';
//         statusColor = const Color(0xff8c6d1f);
//         bgColor = const Color(0xfffffcf4);
//         break;
//     }
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 24,
//       ),
//       child: Row(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 4),
//                 child: Text(
//                   title,
//                   style: titleStyle,
//                 ),
//               ),
//               Text(
//                 subtitle,
//                 style: subtitleStyle,
//               ),
//             ],
//           ),
//           Expanded(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 8,
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: const BorderRadius.all(Radius.circular(8)),
//                     color: bgColor,
//                   ),
//                   child: Text(
//                     statusLabel,
//                     style: subtitleStyle.copyWith(
//                       color: statusColor,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
