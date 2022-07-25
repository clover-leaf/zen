import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/dashboard/dashboard.dart';
import 'package:flutter_firestore/dashboard_detail/view/dashboard_detail_page.dart';
import 'package:iot_repository/iot_repository.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardBloc(
        repository: context.read<IotRepository>(),
      )..add(const GetAllProject()),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final boxSize = MediaQuery.of(context).size.width / 2;
    final status = context.select((DashboardBloc bloc) => bloc.state.status);
    final projects =
        context.select((DashboardBloc bloc) => bloc.state.projects);

    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatingButton(
        icon: SvgIcon.add,
      ),
      bottomNavigationBar: const NavBar(),
      body: Column(
        children: [
          Header(
            title: 'My dashboard',
            subtitle: '${dashboardList.length} projects',
            hasBackButton: false,
          ),
          if (status == DashboardStatus.loading)
            const LoadingCircle()
          else if (status == DashboardStatus.failure)
            const Text('Failure')
          else if (status == DashboardStatus.success)
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
                    children: List.generate(projects.length, (index) {
                      final project = projects[index];
                      return SquareBox(
                        boxSize: boxSize,
                        title: project.projectName,
                        subtile: project.city,
                        onTapped: () => Navigator.push<void>(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) =>
                                DashboardDetailPage(project: project),
                            transitionsBuilder: (c, anim, a2, child) =>
                                FadeTransition(opacity: anim, child: child),
                            transitionDuration:
                                const Duration(milliseconds: 250),
                          ),
                        ),
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
