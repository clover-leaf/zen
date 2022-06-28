import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeatureBox extends StatelessWidget {
  const FeatureBox({
    super.key,
    required this.iconData,
    required this.text,
    required this.onTapped,
  });

  final IconData iconData;
  final String text;
  final Function() onTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        color: const Color(0xffffffff),
        height: 72,
        width: 72,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              iconData,
              size: 24,
              color: const Color(0xffba0011),
            ),
            const SizedBox(height: 12),
            Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xff666a78),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserButton extends StatelessWidget {
  const UserButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        color: Color(0xffffffff),
      ),
      child: const FaIcon(
        FontAwesomeIcons.solidUser,
        size: 20,
        color: Color(0xffee345f),
      ),
    );
  }
}
