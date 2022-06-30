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
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          name,
          style: const TextStyle(
            color: Color(0xffffffff),
            fontSize: 12,
            letterSpacing: 2,
          ),
        ),
        const Spacer(),
        Text(
          '$value',
          style: const TextStyle(
            color: Color(0xffffffff),
            fontSize: 12,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          unit,
          style: const TextStyle(
            color: Color(0xffffffff),
            fontSize: 12,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}

class LegendsListWidget extends StatelessWidget {
  const LegendsListWidget({
    super.key,
    this.direction = Axis.horizontal,
    required this.legends,
  });
  final List<Legend> legends;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: direction,
      spacing: 16,
      runSpacing: 16,
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
