import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:iot_api/iot_api.dart';

class PieChartCustom extends StatelessWidget {
  const PieChartCustom({
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

  double roundUp(double inp) {
    return double.parse(inp.toStringAsFixed(1));
  }

  List<PieChartSectionData> showingSections(
    List<Color> colors,
    List<double> values,
  ) {
    const fontSize = 14.0;
    const radius = 50.0;
    final total = values.sum;
    final normalized =
        values.map((value) => roundUp(value / total * 100)).toList();
    return List.generate(values.length, (index) {
      return PieChartSectionData(
        color: colors[index],
        value: normalized[index],
        title: '${normalized[index]}%',
        radius: radius,
        titleStyle: const TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Color(0xffffffff),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        startDegreeOffset: 270,
        borderData: FlBorderData(
          show: false,
        ),
        sectionsSpace: 8,
        centerSpaceRadius: 40,
        sections: showingSections(
          colors,
          liveDataGroup.map((liveDatas) => liveDatas.last.value).toList(),
        ),
      ),
    );
  }
}
