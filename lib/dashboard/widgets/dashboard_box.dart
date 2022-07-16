import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/dashboard/models/models.dart';
import 'package:flutter_firestore/dashboard_detail/dashboard_detail.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardBox extends StatelessWidget {
  const DashboardBox({
    super.key,
    required this.boxSize,
    required this.info,
  });

  final double boxSize;
  final DashboardInfo info;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.push<void>(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => DashboardDetailPage(info: info),
          transitionsBuilder: (c, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: const Duration(milliseconds: 250),
        ),
      ),
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
                info.iconPath.getPath(),
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              info.name,
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              info.subtitle,
              style: Theme.of(context).textTheme.headline2,
            )
          ],
        ),
      ),
    );
  }
}
