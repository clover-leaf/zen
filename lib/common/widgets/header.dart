import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/constants/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.title,
    required this.subtitle,
    this.hasBackButton = true,
    this.hasDropdown = false,
    this.onDropdownTapped,
    this.trailer,
  });

  final String title;
  final String subtitle;
  final bool hasBackButton;
  final bool hasDropdown;
  final Function()? onDropdownTapped;
  final Widget? trailer;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 80 + MediaQuery.of(context).viewPadding.top,
      color: const Color(0xffF04243),
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (hasBackButton)
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: SvgPicture.asset(
                        SvgIcon.leftArrow.getPath(),
                        color: const Color(0xffffffff),
                      ),
                    ),
                  )
                else
                  const SizedBox(
                    width: 56,
                  ),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: const Color(0xffffffff)),
                ),
                trailer ??
                    const SizedBox(
                      width: 56,
                    )
              ],
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onDropdownTapped,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: const Color(0xffffffff)),
                ),
                if (hasDropdown)
                  SvgPicture.asset(
                    SvgIcon.downArrow.getPath(),
                    height: 16,
                    width: 16,
                    color: const Color(0xffffffff).withAlpha(193),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
