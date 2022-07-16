import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/profile/profile.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static PageRoute route() {
    return MaterialPageRoute<void>(
      builder: (context) => const ProfilePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatingButton(
        icon: SvgIcon.edit,
      ),
      bottomNavigationBar: const NavBar(),
      body: Column(
        children: [
          Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
            alignment: Alignment.center,
            width: double.infinity,
            height: 64 + MediaQuery.of(context).viewPadding.top,
            color: const Color(0xffF04243),
            child: Text(
              'Clover',
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: const Color(0xffffffff)),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const ProfilePanel(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 32,
                      horizontal: 8,
                    ),
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'QUICK ACTION',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            const SizedBox(height: 32),
                            Wrap(
                              spacing: 16,
                              runSpacing: 32,
                              children: [
                                ...actions.map(
                                  (action) => ActionBox(
                                    action: action,
                                  ),
                                ),
                                const NewActionBox()
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NewActionBox extends StatelessWidget {
  const NewActionBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Container(
        width: 48,
        height: 48,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          border: Border.all(
            width: 2,
            color: const Color(0xffF04243)
                .withAlpha(193),
          ),
        ),
        child: SvgPicture.asset(
          SvgIcon.add.getPath(),
          color: const Color(0xffF04243),
        ),
      ),
    );
  }
}

class ActionBox extends StatelessWidget {
  const ActionBox({
    super.key,
    required this.action,
  });

  final Action action;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              border: Border.all(
                width: 2,
                color: const Color(0xff1A191E).withAlpha(193),
              ),
            ),
            child: SvgPicture.asset(
              action.icon.getPath(),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            action.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}

final actions = <Action>[
  const Action(title: 'change password', icon: SvgIcon.key),
  const Action(title: 'night mode', icon: SvgIcon.night),
  const Action(title: 'lighting #03', icon: SvgIcon.lighting),
];

class Action {
  const Action({
    required this.title,
    required this.icon,
  });

  final String title;
  final SvgIcon icon;
}
