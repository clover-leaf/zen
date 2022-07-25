import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OptionLine extends StatelessWidget {
  const OptionLine({
    super.key,
    required this.title,
    required this.prefixIcon,
    this.enabled = true,
    required this.builder,
  });

  final String title;
  final String prefixIcon;
  final bool enabled;
  final Widget Function(BuildContext) builder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (enabled) {
          showModalBottomSheet<String>(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: builder,
          );
        }
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: Space.contentPaddingHorizontal.value,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SvgPicture.asset(
                prefixIcon,
                color: const Color(0xff757575),
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: const Color(0xff676767),
                    ),
              ),
            ),
            SvgPicture.asset(
              SvgIcon.rightArrow.getPath(),
              color: const Color(0xff757575),
            )
          ],
        ),
      ),
    );
  }
}
