import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/constants/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TappableInfoBox extends StatelessWidget {
  const TappableInfoBox({
    super.key,
    required this.title,
    required this.subtile,
    required this.icon,
    required this.onTapped,
  });

  final String title;
  final String subtile;
  final SvgIcon icon;
  final Function() onTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
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
                  subtile,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 24),
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
