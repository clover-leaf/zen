import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyBottomAppbar extends StatelessWidget {
  const MyBottomAppbar({
    super.key,
    required this.prefixIcon,
    required this.prefixOnTapped,
    required this.postfixIcon,
    required this.postfixOnTapped,
  });

  final String prefixIcon;
  final Function() prefixOnTapped;
  final String postfixIcon;
  final Function() postfixOnTapped;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xffffffff),
      elevation: 20,
      child: SizedBox(
        height: 64,
        child: Row(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: prefixOnTapped,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SvgPicture.asset(
                    prefixIcon,
                    height: 24,
                    width: 24,
                    color: const Color(0xff676767),
                  ),
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: postfixOnTapped,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: SvgPicture.asset(
                  postfixIcon,
                  color: const Color(0xff676767),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
