import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PieChartSample extends StatelessWidget {
  const PieChartSample({super.key});
  static const colors = <Color>[
    Color(0xff4af699),
    Color(0xff09bffe),
  ];
  static const values = <double>[59.4, 40.6];
  static const labels = <String>['Silo A', 'Silo B'];

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
                  'Silos Weights',
                  style: TextStyle(
                    color: Color(0xffffffff),
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
            const Spacer(),
            Row(
              children: [
                Flexible(
                  flex: 2,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections(
                          colors,
                          values,
                        ),
                      ),
                    ),
                  ),
                ),
                // Flexible(
                //   child: Padding(
                //     padding: const EdgeInsets.all(8),
                //     child: LegendsListWidget(
                //       direction: Axis.vertical,
                //       legends: List.generate(
                //         values.length,
                //         (index) => Legend(
                //           labels[index],
                //           colors[index],
                //         ),
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(
    List<Color> colors,
    List<double> values,
  ) {
    return List.generate(2, (index) {
      const fontSize = 14.0;
      const radius = 50.0;
      return PieChartSectionData(
        color: colors[index],
        value: values[index],
        title: '${values[index]}%',
        radius: radius,
        titleStyle: const TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Color(0xffffffff),
        ),
      );
    });
  }
}
