import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/constants/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
    required this.icon,
  });

  final SvgIcon icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(const Color(0xffF04243)),
        shape: MaterialStateProperty.all(
          const CircleBorder(
            side: BorderSide(
              width: 4,
              color: Color(0xffffffff),
            ),
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: SvgPicture.asset(
          icon.getPath(),
          color: const Color(0xffffffff),
        ),
      ),
    );
  }
}
