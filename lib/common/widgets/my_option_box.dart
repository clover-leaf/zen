import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyOptionBox extends StatelessWidget {
  const MyOptionBox({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  final String title;
  final MyIcon icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SvgPicture.asset(
                icon.getPath(),
                color: const Color(0xff212121),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
