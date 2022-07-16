import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/dashboard/models/models.dart';
import 'package:flutter_firestore/workspace/workspace.dart';
import 'package:iot_repository/iot_repository.dart';

class WorkspacePage extends StatelessWidget {
  const WorkspacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WorkspaceBloc(
        repository: context.read<IotRepository>(),
      )..add(const GetAllProject()),
      child: const WorkspaceView(),
    );
  }
}

class WorkspaceView extends StatelessWidget {
  const WorkspaceView({super.key});

  @override
  Widget build(BuildContext context) {
    final boxSize = MediaQuery.of(context).size.width / 2;
    final status = context.select((WorkspaceBloc bloc) => bloc.state.status);
    final projects =
        context.select((WorkspaceBloc bloc) => bloc.state.projects);

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
            title: 'My workspace',
            subtitle: '${projects.length} projects',
            hasBackButton: false,
          ),
          if (status == WorkspaceStatus.loading)
            const LoadingCircle()
          else if (status == WorkspaceStatus.failure)
            const Text('Failure')
          else if (status == WorkspaceStatus.success)
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: const Color(0xffe5e5e5),
                  padding: const EdgeInsets.only(bottom: 2),
                  height: boxSize * ((projects.length + 1) ~/ 2),
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    padding: EdgeInsets.zero,
                    crossAxisCount: 2,
                    children: List.generate(projects.length, (index) {
                      final project = projects[index];
                      return ProjectBox(
                        boxSize: boxSize,
                        project: project,
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
