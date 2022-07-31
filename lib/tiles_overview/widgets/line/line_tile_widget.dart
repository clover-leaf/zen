// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_firestore/common/constants/space.dart';
// import 'package:iot_api/iot_api.dart';

// class LineTileWidget extends StatelessWidget {
//   const LineTileWidget({
//     super.key,
//     required this.tileConfig,
//     required this.value,
//   });

//   final TileConfig tileConfig;
//   final String? value;

//   @override
//   Widget build(BuildContext context) {
//     final textTileData = tileConfig.tileData as TextTileData;
//     final title = tileConfig.title;
//     final prefix = textTileData.prefix;
//     final postfix = textTileData.postfix;
//     final textTheme = Theme.of(context).textTheme;

//     return Container(
//       height: 144,
//       decoration: BoxDecoration(
//         borderRadius: const BorderRadius.all(Radius.circular(8)),
//         border: Border.all(
//           color: const Color(0xffd3d3d3),
//           width: Space.globalBorderWidth.value,
//         ),
//       ),
//       alignment: Alignment.center,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: 12),
//             child: Text(title, style: textTheme.titleMedium),
//           ),
//           if (value == null)
//             const CircularProgressIndicator()
//           else
//             Text(
//               '$prefix $value $postfix',
//               style: textTheme.titleLarge,
//             )
//         ],
//       ),
//     );
//   }
// }

// class LineChartCustom extends StatelessWidget {
//   const LineChartCustom({
//     super.key,
//     required this.liveDataGroup,
//     required this.xAxisGridOffset,
//     required this.colors,
//   }) : assert(
//           liveDataGroup.length == colors.length,
//           'number list live data must equal number of colors',
//         );

//   final List<List<LiveData>> liveDataGroup;
//   final double xAxisGridOffset;
//   final List<Color> colors;

//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       LineChartData(
//         lineTouchData: lineTouchData,
//         gridData: gridData,
//         titlesData: titlesData,
//         borderData: borderData,
//         lineBarsData: [
//           LineChartBarData(
//             isCurved: true,
//             color: const Color(0xff212121),
//             barWidth: 2,
//             isStrokeCapRound: true,
//             dotData: FlDotData(show: false),
//             belowBarData: BarAreaData(show: false),
//             spots: List.generate(
//               liveDataGroup[index].length,
//               (dataIndex) => FlSpot(
//                 dataIndex.toDouble(),
//                 liveDataGroup[index][dataIndex].value,
//               ),
//             ).toList(),
//           )
//         ],
//         minX: 0,
//         maxX: 30,
//         maxY: 50,
//         minY: 10,
//       ),
//       // swapAnimationDuration: const Duration(milliseconds: 250),
//     );
//   }

//   LineTouchData get lineTouchData => LineTouchData(
//         handleBuiltInTouches: true,
//         touchTooltipData: LineTouchTooltipData(
//           tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
//         ),
//       );

//   FlTitlesData get titlesData => FlTitlesData(
//         bottomTitles: AxisTitles(
//           sideTitles: bottomTitles,
//         ),
//         rightTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         topTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//       );

//   Widget bottomTitleWidgets(double value, TitleMeta meta) {
//     final plusOffset = value + xAxisGridOffset;
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       child: plusOffset.remainder(10) == 0
//           ? Text(
//               DateFormat('Hm')
//                   .format(liveDataGroup[0][value.toInt()].timestamp),
//               style: GoogleFonts.montserrat(
//                 fontSize: 12,
//                 letterSpacing: 16 / 12,
//                 fontWeight: FontWeight.w700,
//                 height: 16 / 12,
//                 color: const Color(0xff1A191E).withAlpha(193),
//               ),
//               textAlign: TextAlign.center,
//             )
//           : Container(),
//     );
//   }

//   SideTitles get bottomTitles => SideTitles(
//         showTitles: true,
//         reservedSize: 32,
//         interval: 1,
//         getTitlesWidget: bottomTitleWidgets,
//       );

//   FlGridData get gridData => FlGridData(
//         show: false,
//         drawVerticalLine: true,
//         verticalInterval: 1,
//         getDrawingVerticalLine: (value) {
//           if ((value + xAxisGridOffset).remainder(10) == 0) {
//             return FlLine(
//               color: const Color(0xff72719b),
//               strokeWidth: 1,
//             );
//           } else {
//             return FlLine(
//               strokeWidth: 1,
//               color: Colors.transparent,
//             );
//           }
//         },
//         drawHorizontalLine: false,
//         // horizontalInterval: 10,
//         // getDrawingHorizontalLine: (value) {
//         //   return FlLine(
//         //     color: const Color(0xff72719b),
//         //     strokeWidth: 1,
//         //   );
//         // },
//       );

//   FlBorderData get borderData => FlBorderData(
//         show: false,
//         border: const Border.symmetric(
//           vertical: BorderSide(color: Color(0xff72719b)),
//         ),
//       );
// }
