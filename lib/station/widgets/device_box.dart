import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/constants/icons.dart';
import 'package:flutter_firestore/device/device.dart';
import 'package:flutter_firestore/device_detail_new/device_detail_new.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeviceBox extends StatelessWidget {
  const DeviceBox({
    super.key,
    required this.deviceInfo,
  });

  final DeviceInfo deviceInfo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push<void>(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => DeviceDetailNewPage(
            deviceInfo: deviceInfo,
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
                SvgIcon.gasStation.getPath(),
                color: Theme.of(context).primaryColor,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deviceInfo.name,
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(height: 8),
                Text(
                  'Seattle Station',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  deviceInfo.project,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 24,
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
