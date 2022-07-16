import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/constants/icons.dart';
import 'package:flutter_firestore/station/station.dart' show StationPage;
import 'package:flutter_svg/flutter_svg.dart';

class StationBox extends StatelessWidget {
  const StationBox({
    super.key,
    required this.title,
    required this.totalDevice,
    required this.icon,
  });

  final String title;
  final int totalDevice;
  final SvgIcon icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push<void>(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => StationPage(
            title: title,
            totalDevice: totalDevice,
          ),
          transitionsBuilder: (c, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: const Duration(milliseconds: 250),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 8,
        ),
        alignment: Alignment.center,
        color: const Color(0xffffffff),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 24,
              ),
              child: SvgPicture.asset(
                icon.getPath(),
                color: Theme.of(context).primaryColor,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(height: 8),
                Text(
                  totalDevice > 1
                      ? '$totalDevice devices'
                      : '$totalDevice device',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                0,
                12,
                24,
                12,
              ),
              child: SvgPicture.asset(
                SvgIcon.rightArrow.getPath(),
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
