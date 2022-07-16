import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/dashboard/dashboard.dart';
import 'package:flutter_firestore/project/project.dart';
import 'package:flutter_firestore/project/widgets/widgets.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({
    super.key,
    required this.info,
  });

  static PageRoute route({required DashboardInfo info}) {
    return MaterialPageRoute<void>(
      builder: (context) => ProjectPage(
        info: info,
      ),
    );
  }

  final DashboardInfo info;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProjectBloc(info: info),
      child: const ProjectView(),
    );
  }
}

class ProjectView extends StatelessWidget {
  const ProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    final info = context.select((ProjectBloc bloc) => bloc.state.info);
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const NavBar(),
      body: Column(
        children: [
          Header(
            title: info.name,
            subtitle: 'Stations',
            hasDropdown: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const StationBox(
                    title: 'Seattle Station',
                    totalDevice: 3,
                    icon: SvgIcon.gasStation,
                  ),
                  Container(height: 2, color: const Color(0xffe5e5e5)),
                  const StationBox(
                    title: 'Chicago Station',
                    totalDevice: 2,
                    icon: SvgIcon.gasStation,
                  ),
                  Container(height: 2, color: const Color(0xffe5e5e5)),
                  const StationBox(
                    title: 'Dallas Station',
                    totalDevice: 5,
                    icon: SvgIcon.gasStation,
                  ),
                  Container(height: 2, color: const Color(0xffe5e5e5)),
                  const StationBox(
                    title: 'Washington DC Station',
                    totalDevice: 4,
                    icon: SvgIcon.gasStation,
                  ),
                  Container(height: 2, color: const Color(0xffe5e5e5)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
