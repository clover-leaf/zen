
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartCustom extends StatelessWidget {
  const BarChartCustom({
    super.key,
    required this.colors,
  });

  static const pilateColor = Color(0xff632af2);
  static const cyclingColor = Color(0xffffb3ba);
  static const quickWorkoutColor = Color(0xff578eff);
  static const betweenSpace = 0.3;

  final List<Color> colors;

  BarChartGroupData generateGroupData(
    int x,
    double pilates,
    double quickWorkout,
    double cycling,
  ) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: pilates,
          color: pilateColor,
          width: 5,
        ),
        BarChartRodData(
          fromY: pilates + betweenSpace,
          toY: pilates + betweenSpace + quickWorkout,
          color: quickWorkoutColor,
          width: 5,
        ),
        BarChartRodData(
          fromY: pilates + betweenSpace + quickWorkout + betweenSpace,
          toY: pilates + betweenSpace + quickWorkout + betweenSpace + cycling,
          color: cyclingColor,
          width: 5,
        ),
      ],
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff787694),
      fontSize: 10,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'JAN';
        break;
      case 1:
        text = 'FEB';
        break;
      case 2:
        text = 'MAR';
        break;
      case 3:
        text = 'APR';
        break;
      case 4:
        text = 'MAY';
        break;
      case 5:
        text = 'JUN';
        break;
      case 6:
        text = 'JUL';
        break;
      case 7:
        text = 'AUG';
        break;
      case 8:
        text = 'SEP';
        break;
      case 9:
        text = 'OCT';
        break;
      case 10:
        text = 'NOV';
        break;
      case 11:
        text = 'DEC';
        break;
      default:
        text = '';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
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
              getTitlesWidget: bottomTitles,
              reservedSize: 16,
            ),
          ),
        ),
        barTouchData: BarTouchData(enabled: false),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
        barGroups: [
          generateGroupData(0, 2, 3, 2),
          generateGroupData(1, 2, 5, 1.7),
          generateGroupData(2, 1.3, 3.1, 2.8),
          generateGroupData(3, 3.1, 4, 3.1),
          generateGroupData(4, 0.8, 3.3, 3.4),
          generateGroupData(5, 2, 5.6, 1.8),
          generateGroupData(6, 1.3, 3.2, 2),
          generateGroupData(7, 2.3, 3.2, 3),
          generateGroupData(8, 2, 4.8, 2.5),
          generateGroupData(9, 1.2, 3.2, 2.5),
          generateGroupData(10, 1, 4.8, 3),
          generateGroupData(11, 2, 4.4, 2.8),
          generateGroupData(12, 1, 4.8, 3),
          generateGroupData(13, 2, 4.4, 2.8),
          generateGroupData(14, 1, 4.8, 3),
          generateGroupData(15, 2, 4.4, 2.8),
          generateGroupData(16, 1, 4.8, 3),
          generateGroupData(17, 2, 4.4, 2.8),
          generateGroupData(18, 1, 4.8, 3),
          generateGroupData(19, 2, 4.4, 2.8),
          generateGroupData(20, 1, 4.8, 3),
          generateGroupData(11, 2, 4.4, 2.8),
          generateGroupData(12, 1, 4.8, 3),
          generateGroupData(13, 2, 4.4, 2.8),
          generateGroupData(14, 1, 4.8, 3),
          generateGroupData(15, 2, 4.4, 2.8),
          generateGroupData(16, 1, 4.8, 3),
          generateGroupData(17, 2, 4.4, 2.8),
          generateGroupData(18, 1, 4.8, 3),
          generateGroupData(19, 2, 4.4, 2.8),
          generateGroupData(20, 1, 4.8, 3),
        ],
        maxY: 10 + (betweenSpace * 3),
      ),
    );
  }
}