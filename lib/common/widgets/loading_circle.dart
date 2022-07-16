import 'package:flutter/material.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Padding(
          padding: EdgeInsets.only(top: 24),
          child: CircularProgressIndicator(
            strokeWidth: 8,
            color: Color(0xffF04243),
          ),
        ),
      ],
    );
  }
}
