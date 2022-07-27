import 'package:flutter/material.dart';

class MyCircularProgress extends StatelessWidget {
  const MyCircularProgress({
    super.key,
    required this.size,
    this.padding = EdgeInsets.zero,
  });

  final double size;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: padding ?? EdgeInsets.zero,
      child: SizedBox(
        height: size,
        width: size,
        child: const CircularProgressIndicator(
          color: Color(0xff881b1b),
        ),
      ),
    );
  }
}
