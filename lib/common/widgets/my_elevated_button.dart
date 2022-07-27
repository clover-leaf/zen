import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.overlayColor = const Color(0xffd3d3d3),
    this.bgColor = const Color(0xffffffff),
    this.height,
    this.padding = EdgeInsets.zero,
  });

  final double? height;
  final Widget? child;
  final Color bgColor;
  final Color overlayColor;
  final EdgeInsets padding;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(overlayColor),
          backgroundColor: MaterialStateProperty.all(bgColor),
          elevation: MaterialStateProperty.all(0),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
