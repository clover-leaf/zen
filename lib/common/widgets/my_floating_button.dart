import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyFloatingButton extends StatelessWidget {
  const MyFloatingButton({
    super.key,
    required this.onPressed,
    this.icon = MyIcon.add,
  });

  final Function() onPressed;
  final MyIcon icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Theme.of(context).primaryColor,
      child: SvgPicture.asset(
        MyIcon.add.getPath(),
        color: const Color(0xffffffff),
      ),
    );
  }
}
