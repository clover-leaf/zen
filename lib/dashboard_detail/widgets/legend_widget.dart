import 'package:flutter/material.dart';

class LegendWidget extends StatelessWidget {
  const LegendWidget({
    super.key,
    required this.name,
    required this.color,
    required this.value,
    required this.unit,
  });
  final String name;
  final Color color;
  final double value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name.toUpperCase(),
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              // width: 48,
              child: Text(
                value.toString(),
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: color,
                    ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              unit,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ],
    );
  }
}

class LegendsListWidget extends StatelessWidget {
  const LegendsListWidget({
    super.key,
    this.direction = Axis.vertical,
    required this.legends,
  });
  final List<Legend> legends;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 48,
      runSpacing: 24,
      children: legends
          .map(
            (legend) => LegendWidget(
              name: legend.name,
              color: legend.color,
              value: legend.value,
              unit: legend.unit,
            ),
          )
          .toList(),
    );
  }
}

class Legend {
  Legend(
    this.name,
    this.color,
    this.value,
    this.unit,
  );
  final String name;
  final Color color;
  final double value;
  final String unit;
}
