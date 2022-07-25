import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SquareBox extends StatelessWidget {
  const SquareBox({
    super.key,
    required this.boxSize,
    required this.title,
    required this.subtile,
    required this.onTapped,
  });

  final double boxSize;
  final String title;
  final String subtile;
  final Function() onTapped;

  @override
  Widget build(BuildContext context) {
    final icons = [
      SvgIcon.air,
      SvgIcon.gasStation,
      SvgIcon.lighting,
      SvgIcon.water,
      SvgIcon.enviroment,
    ];
    final randomIcon = icons[Random().nextInt(icons.length)];
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTapped,
      child: Container(
        height: boxSize,
        width: boxSize,
        color: Theme.of(context).backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(
                randomIcon.getPath(),
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtile,
              style: Theme.of(context).textTheme.headline2,
            )
          ],
        ),
      ),
    );
  }
}
