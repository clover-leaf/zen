import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_firestore/app_configure/app_configure.dart';
import 'package:flutter_firestore/app_dashboard/app_dashboard.dart';
import 'package:flutter_firestore/app_notification/app_notification.dart';
import 'package:flutter_firestore/app_overview/app_overview.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/home/home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);
    final homeTabButtonWidth =
        MediaQuery.of(context).size.width / HomeTab.values.length;

    return Scaffold(
      body: LazyLoadIndexedStack(
        index: selectedTab.index,
        children: const <Widget>[
          AppOverviewPage(),
          AppDashboardPage(),
          AppNotificationPage(),
          AppConfigurePage(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: const Color(0xffffffff),
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              _HomeTabButton(
                groupValue: selectedTab,
                value: HomeTab.overview,
                iconData: FontAwesomeIcons.house,
                width: homeTabButtonWidth,
                // iconPath: SvgIcon.overview.getPath(),
              ),
              _HomeTabButton(
                groupValue: selectedTab,
                value: HomeTab.dashboard,
                iconData: FontAwesomeIcons.chartSimple,
                width: homeTabButtonWidth,
              ),
              _HomeTabButton(
                groupValue: selectedTab,
                value: HomeTab.notification,
                iconData: FontAwesomeIcons.solidBell,
                width: homeTabButtonWidth,
              ),
              _HomeTabButton(
                groupValue: selectedTab,
                value: HomeTab.configure,
                iconData: FontAwesomeIcons.gear,
                width: homeTabButtonWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    // super.key,
    required this.groupValue,
    required this.value,
    required this.iconData,
    required this.width,
  });

  final HomeTab groupValue;
  final HomeTab value;
  final IconData iconData;
  final double width;

  @override
  Widget build(BuildContext context) {
    final isSelected = groupValue == value;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => context.read<HomeCubit>().setTab(value),
      child: Container(
        width: width,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              iconData,
              color: isSelected
                  ? const Color(0xff225ddd)
                  : const Color(0xff7a7a7a),
                  size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              value.getName(),
              style: TextStyle(
                color: isSelected
                    ? const Color(0xff225ddd)
                    : const Color(0xff7a7a7a),
                fontSize: 11,
              ),
            )
          ],
        ),
      ),
    );
  }
}
