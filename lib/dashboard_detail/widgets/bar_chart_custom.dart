import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:iot_api/iot_api.dart';

class BarChartCustom extends StatelessWidget {
  const BarChartCustom({
    super.key,
    required this.colors,
    required this.liveDataGroup,
    required this.xAxisGridOffset,
  }) : assert(
          liveDataGroup.length == colors.length,
          'number list live data must equal number of colors',
        );

  static const betweenSpace = 0.2;

  final List<List<LiveData>> liveDataGroup;
  final double xAxisGridOffset;
  final List<Color> colors;

  double normalize(double inp) {
    return inp / 12;
  }

  BarChartGroupData generateGroupData(
    int x,
    List<double> values,
  ) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: List.generate(
        values.length,
        (index) => BarChartRodData(
          fromY: normalize(values.sublist(0, index).sum) + betweenSpace * index,
          toY: normalize(values.sublist(0, index + 1).sum) +
              betweenSpace * index,
          color: colors[index],
          width: 6,
        ),
      ).toList(),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final plusOffset = value + xAxisGridOffset;
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: plusOffset.remainder(10) == 0
          ? Text(
              DateFormat('Hm')
                  .format(liveDataGroup[0][value.toInt()].timestamp),
              style: GoogleFonts.montserrat(
                fontSize: 12,
                letterSpacing: 16 / 12,
                fontWeight: FontWeight.w700,
                height: 16 / 12,
                color: const Color(0xff1A191E).withAlpha(193),
              ),
              textAlign: TextAlign.center,
            )
          : Container(),
    );
  }

  double get maximumY {
    final sumList = List.generate(
      liveDataGroup.first.length,
      (index) => liveDataGroup
          .map((liveDatas) => liveDatas[index].value)
          .reduce((cur, prev) => cur + prev),
    );
    final max = sumList.reduce((cur, next) => cur > next ? cur : next);
    return max;
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceBetween,
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(),
          rightTitles: AxisTitles(),
          topTitles: AxisTitles(),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              interval: 1,
              getTitlesWidget: bottomTitleWidgets,
            ),
          ),
        ),
        barTouchData: BarTouchData(enabled: false),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
        barGroups: List.generate(
          liveDataGroup.first.length,
          (index) => generateGroupData(
            index,
            liveDataGroup.map((liveDatas) => liveDatas[index].value).toList(),
          ),
        ).toList(),
        maxY: normalize(maximumY) + betweenSpace * 3,
      ),
    );
  }
}
