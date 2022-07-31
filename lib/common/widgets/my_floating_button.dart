import 'package:flutter/material.dart';
import 'package:flutter_firestore/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyFloatingButton extends StatelessWidget {
  const MyFloatingButton({
    super.key,
    required this.onPressed,
    this.icon,
  });

  final Function() onPressed;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Theme.of(context).primaryColor,
      child: SvgPicture.asset(
        icon ?? Assets.icons.add,
        color: const Color(0xffffffff),
      ),
    );
  }
}
