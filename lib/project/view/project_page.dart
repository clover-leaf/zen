import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/project/project.dart';
import 'package:iot_api/iot_api.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({
    super.key,
    required this.project,
  });

  static PageRoute route({required Project project}) {
    return MaterialPageRoute<void>(
      builder: (context) => ProjectPage(
        project: project,
      ),
    );
  }

  final Project project;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProjectBloc(project: project),
      child: const ProjectView(),
    );
  }
}

class ProjectView extends StatelessWidget {
  const ProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    final tab = context.select((ProjectBloc bloc) => bloc.state.tab);
    final project = context.select((ProjectBloc bloc) => bloc.state.project);
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const NavBar(),
      body: Column(
        children: [
          Header(
            title: project.projectName,
            subtitle: project.city,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                TabButton(
                  label: ProjectTab.stations.getName(),
                  tab: ProjectTab.stations,
                  selectedTab: tab,
                  onTapped: () => context
                      .read<ProjectBloc>()
                      .add(const TabChanged(ProjectTab.stations)),
                ),
                TabButton(
                  label: ProjectTab.infomation.getName(),
                  tab: ProjectTab.infomation,
                  selectedTab: tab,
                  onTapped: () => context
                      .read<ProjectBloc>()
                      .add(const TabChanged(ProjectTab.infomation)),
                ),
                TabButton(
                  label: ProjectTab.location.getName(),
                  tab: ProjectTab.location,
                  selectedTab: tab,
                  onTapped: () => context
                      .read<ProjectBloc>()
                      .add(const TabChanged(ProjectTab.location)),
                ),
              ],
            ),
          ),
          Expanded(
            child: LazyLoadIndexedStack(
              index: tab.index,
              children: [
                StationsTabPage(project: project),
                InfomationTabPage(project: project),
                MapTabPage(project: project),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
