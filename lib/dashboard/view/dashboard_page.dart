import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/dashboard/dashboard.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardBloc(),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final boxSize = MediaQuery.of(context).size.width / 2;

    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatingButton(icon: SvgIcon.add,),
      bottomNavigationBar: const NavBar(),
      body: Column(
        children: [
          Header(
            title: 'My dashboard',
            subtitle: '${dashboardList.length} projects',
            hasBackButton: false,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: const Color(0xffe5e5e5),
                padding: const EdgeInsets.only(bottom: 2),
                height: boxSize * ((dashboardList.length + 1) ~/ 2),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  padding: EdgeInsets.zero,
                  crossAxisCount: 2,
                  children: List.generate(dashboardList.length, (index) {
                    final info = dashboardList[index];
                    return DashboardBox(
                      boxSize: boxSize,
                      info: info,
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final List<DashboardInfo> dashboardList = [
  DashboardInfo(
    name: 'Air Quality',
    totalStation: 2,
    iconPath: SvgIcon.air,
  ),
  DashboardInfo(
    name: 'EV Charger',
    totalStation: 3,
    iconPath: SvgIcon.gasStation,
  ),
  DashboardInfo(
    name: 'House Lighting',
    totalStation: 1,
    iconPath: SvgIcon.lighting,
  ),
  DashboardInfo(
    name: 'Water Monitor',
    totalStation: 2,
    iconPath: SvgIcon.water,
  ),
  DashboardInfo(
    name: 'Enviroment Monitor',
    totalStation: 4,
    iconPath: SvgIcon.enviroment,
  ),
  DashboardInfo(
    name: 'Building Monitor',
    totalStation: 3,
    iconPath: SvgIcon.enviroment,
  ),
];
