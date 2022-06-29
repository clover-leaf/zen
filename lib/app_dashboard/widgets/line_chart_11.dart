import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class _LineChart extends StatelessWidget {
  const _LineChart({
    required this.spots,
    required this.xAxisGridOffset,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData,
      // swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  final List<List<FlSpot>> spots;
  final double xAxisGridOffset;
  final DateTime time;

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: const Color(0xff4af699),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: spots[0],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        color: const Color(0xff09bffe),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: spots[1],
      );

  LineChartData get sampleData => LineChartData(
        lineTouchData: lineTouchData,
        gridData: gridData,
        titlesData: titlesData,
        borderData: borderData,
        lineBarsData: lineBarsData,
        minX: 0,
        maxX: 30,
        maxY: 50,
        minY: 10,
      );

  LineTouchData get lineTouchData => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          axisNameSize: 18,
          axisNameWidget: const Padding(
            padding: EdgeInsets.only(left: 24),
            child: Text(
              'Temperature °C',
              style: TextStyle(
                color: Color(0xff75729e),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData => [
        lineChartBarData1_1,
        lineChartBarData1_2,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return Text(
      value.toInt().toString(),
      style: const TextStyle(
        color: Color(0xff75729e),
        fontSize: 13,
      ),
      textAlign: TextAlign.center,
    );
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 10,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final plusOffset = value + xAxisGridOffset;
    final offsetTime = plusOffset ~/ 10;
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: plusOffset.remainder(10) == 0
          ? Text(
              DateFormat('Hm')
                  .format(time.add(Duration(minutes: 15 * offsetTime))),
              style: const TextStyle(
                color: Color(0xff75729e),
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            )
          : Container(),
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 10,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff72719b),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          if ((value + xAxisGridOffset).remainder(10) == 0) {
            return FlLine(
              color: const Color(0xff72719b),
              strokeWidth: 1,
            );
          } else {
            return FlLine(
              strokeWidth: 1,
              color: Colors.transparent,
            );
          }
        },
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff72719b)),
      );
}

class LineChartSample11 extends StatelessWidget {
  const LineChartSample11({
    super.key,
    required this.spots,
    required this.xAxisGridOffset,
    required this.time,
  });

  final List<List<FlSpot>> spots;
  final double xAxisGridOffset;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.22,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          gradient: LinearGradient(
            colors: [
              Color(0xff2c274c),
              Color(0xff46426c),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text(
                  'Silos Temperature',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                FaIcon(
                  FontAwesomeIcons.upRightAndDownLeftFromCenter,
                  size: 13,
                  color: Colors.white,
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                FaIcon(
                  FontAwesomeIcons.clock,
                  size: 11,
                  color: Color(0xffffffff),
                ),
                SizedBox(width: 8),
                Text(
                  'Realtime - last 10 minutes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _LineChart(
                spots: spots,
                xAxisGridOffset: xAxisGridOffset,
                time: time,
              ),
            ),
            const SizedBox(height: 8),
            LegendLine(
              spots: spots[0],
              color: const Color(0xff4af699),
            ),
            const SizedBox(height: 4),
            LegendLine(spots: spots[1],
            color: const Color(0xff09bffe),),
          ],
        ),
      ),
    );
  }
}

class LegendLine extends StatelessWidget {
  const LegendLine({
    super.key,
    required this.spots,
    required this.color,
  });

  final List<FlSpot> spots;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 2,
          width: 24,
          color: color,
        ),
        const SizedBox(width: 8),
        const Text(
          'Silo A temperature',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            letterSpacing: 2,
          ),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Text(
          '${spots.last.y} °C',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            letterSpacing: 2,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
