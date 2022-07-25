// import 'package:flutter/material.dart';
// import 'package:flutter_firestore/dashboard_detail/dashboard_detail.dart';

// class RectangleChartCard extends StatelessWidget {
//   const RectangleChartCard({
//     super.key,
//     required this.title,
//     required this.liveValues,
//     required this.labels,
//     required this.unit,
//     required this.colors,
//     required this.chartWidget,
//   });

//   final String title;
//   final List<double> liveValues;
//   final List<String> labels;
//   final String unit;
//   final List<Color> colors;
//   final Widget chartWidget;

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.2,
//       child: Container(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 32,
//           vertical: 24,
//         ),
//         color: const Color(0xffffffff),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: Theme.of(context).textTheme.headline1,
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 24),
//             AspectRatio(
//               aspectRatio: 2,
//               child: chartWidget,
//             ),
//             const SizedBox(height: 16),
//             LegendsListWidget(
//               direction: Axis.horizontal,
//               legends: List.generate(
//                 labels.length,
//                 (index) => Legend(
//                   labels[index],
//                   colors[index],
//                   liveValues[index],
//                   unit,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
