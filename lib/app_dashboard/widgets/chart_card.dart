import 'package:flutter/material.dart';
import 'package:flutter_firestore/app_dashboard/widgets/legend_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChartCard extends StatelessWidget {
  const ChartCard({
    super.key,
    required this.title,
    required this.liveValues,
    required this.labels,
    required this.unit,
    required this.colors,
    required this.chartWidget,
  });

  final String title;
  final List<double> liveValues;
  final List<String> labels;
  final String unit;
  final List<Color> colors;
  final Widget chartWidget;

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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                const FaIcon(
                  FontAwesomeIcons.upRightAndDownLeftFromCenter,
                  size: 13,
                  color: Colors.white,
                )
              ],
            ),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 2,
              child: chartWidget,
            ),
            const SizedBox(height: 14),
            LegendsListWidget(
              legends: List.generate(
                labels.length,
                (index) => Legend(
                  labels[index],
                  colors[index],
                  liveValues[index],
                  unit,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
