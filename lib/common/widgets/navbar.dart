import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/message/view/view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: const Color(0xff191A1E),
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              child: SvgPicture.asset(
                SvgIcon.menu.getPath(),
                color: const Color(0xffffffff),
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.push<void>(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => const MessagePage(),
                transitionsBuilder: (c, anim, a2, child) =>
                    FadeTransition(opacity: anim, child: child),
                transitionDuration: const Duration(milliseconds: 250),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              child: Badge(
                badgeContent: Text(
                  '2',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: const Color(0xffffffff),
                        fontSize: 10,
                      ),
                ),
                padding: const EdgeInsets.all(4),
                badgeColor: const Color(0xffF04243),
                child: SvgPicture.asset(
                  SvgIcon.message.getPath(),
                  color: const Color(0xffffffff),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
