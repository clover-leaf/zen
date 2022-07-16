// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/dashboard/dashboard.dart';
import 'package:flutter_firestore/device/device.dart';
import 'package:flutter_firestore/message/view/view.dart';
import 'package:flutter_firestore/profile/profile.dart';
import 'package:flutter_firestore/workspace/workspace.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xffF04243),
      width: 256,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          32,
          16 + MediaQuery.of(context).viewPadding.top,
          16,
          16,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    'Clover',
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: const Color(0xffffffff)),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => Navigator.of(context).pop(),
                  child: SvgPicture.asset(
                    SvgIcon.close.getPath(),
                    color: const Color(0xffffffff),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _MenuItem(
              onTapped: () => Navigator.push<void>(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => const ProfilePage(),
                  transitionsBuilder: (c, anim, a2, child) =>
                      FadeTransition(opacity: anim, child: child),
                  transitionDuration: const Duration(milliseconds: 250),
                ),
              ).then((value) => Navigator.pop(context)),
              label: 'My profile',
              icon: SvgIcon.profile,
            ),
            _MenuItem(
              onTapped: () => Navigator.push<void>(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => const DashboardPage(),
                  transitionsBuilder: (c, anim, a2, child) =>
                      FadeTransition(opacity: anim, child: child),
                  transitionDuration: const Duration(milliseconds: 250),
                ),
              ).then((value) => Navigator.pop(context)),
              label: 'My dashboard',
              icon: SvgIcon.home,
            ),
            _MenuItem(
              onTapped: () => Navigator.push<void>(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => const MessagePage(),
                  transitionsBuilder: (c, anim, a2, child) =>
                      FadeTransition(opacity: anim, child: child),
                  transitionDuration: const Duration(milliseconds: 250),
                ),
              ).then((value) => Navigator.pop(context)),
              label: 'Messages',
              icon: SvgIcon.message,
              isAtEnd: false,
              trailer: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Container(
                  height: 24,
                  width: 24,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0xffffffff),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '2',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: const Color(0xff292D32),
                        ),
                  ),
                ),
              ),
            ),
            _MenuItem(
              onTapped: () => Navigator.push<void>(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => const DevicePage(),
                  transitionsBuilder: (c, anim, a2, child) =>
                      FadeTransition(opacity: anim, child: child),
                  transitionDuration: const Duration(milliseconds: 250),
                ),
              ).then((value) => Navigator.pop(context)),
              label: 'My devices',
              icon: SvgIcon.device,
            ),
            _MenuItem(
              onTapped: () => Navigator.push<void>(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => const WorkspacePage(),
                  transitionsBuilder: (c, anim, a2, child) =>
                      FadeTransition(opacity: anim, child: child),
                  transitionDuration: const Duration(milliseconds: 250),
                ),
              ),
              label: 'My workspace',
              icon: SvgIcon.archive,
            ),
            _MenuItem(
              onTapped: () {},
              label: 'Member access',
              icon: SvgIcon.people,
            ),
            _MenuItem(
              onTapped: () {},
              label: 'Support',
              icon: SvgIcon.support,
            ),
            const Spacer(),
            _MenuItem(
              onTapped: () {},
              label: 'Night Mode',
              icon: SvgIcon.night,
              // trailer: CupertinoSwitch(
              //   value: context.read<ThemeCubit>().state.isDark,
              //   onChanged: (value) => context.read<ThemeCubit>().toggle(),
              // ),
            ),
            _MenuItem(
              onTapped: () {},
              label: 'Sign out',
              icon: SvgIcon.logout,
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.label,
    required this.icon,
    required this.onTapped,
    this.isAtEnd = true,
    this.trailer,
  });

  final String label;
  final SvgIcon icon;
  final Function() onTapped;
  final bool isAtEnd;
  final Widget? trailer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTapped,
      child: Row(
        children: [
          Container(
            height: 56,
            padding: const EdgeInsets.only(right: 12),
            child: SvgPicture.asset(
              icon.getPath(),
              color: const Color(0xffffffff),
            ),
          ),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: const Color(0xffffffff)),
          ),
          if (isAtEnd) const Spacer(),
          if (trailer != null) trailer!,
        ],
      ),
    );
  }
}
