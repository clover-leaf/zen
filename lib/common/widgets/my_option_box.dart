import 'package:flutter/material.dart';
import 'package:flutter_firestore/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyOptionBox extends StatelessWidget {
  const MyOptionBox({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon,
    this.innerPadding = EdgeInsets.zero,
  });

  final String title;
  final String? icon;
  final Function() onPressed;
  final EdgeInsets innerPadding;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      color: const Color(0xffffffff),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          child: Padding(
            padding: innerPadding,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: textTheme.titleMedium,
                  ),
                ),
                SvgPicture.asset(
                  icon ?? Assets.icons.rightMd,
                  color: const Color(0xff676767),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
