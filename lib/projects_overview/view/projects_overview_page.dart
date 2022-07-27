import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/common/widgets/widgets.dart';
import 'package:flutter_firestore/project_detail/view/view.dart';
import 'package:flutter_firestore/projects_overview/projects_overview.dart';
import 'package:iot_repository/iot_repository.dart';

class ProjectsOverviewPage extends StatelessWidget {
  const ProjectsOverviewPage({super.key});

  static PageRoute route() {
    return PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
        create: (_) => ProjectsOverviewBloc(
          repository: context.read<IotRepository>(),
        )..add(const InitializeRequested()),
        child: const ProjectsOverviewPage(),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0, 1);
        const end = Offset.zero;
        const curve = Curves.ease;
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const ProjectsOverviewView();
  }
}

class ProjectsOverviewView extends StatelessWidget {
  const ProjectsOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final state = context.watch<ProjectsOverviewBloc>().state;
    final projects = state.projects;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MyFloatingButton(onPressed: () {}),
      bottomNavigationBar: MyBottomAppbar(
        prefixIcon: MyIcon.leftButton.getPath(),
        prefixOnTapped: () => Navigator.of(context).pop(),
        postfixIcon: MyIcon.template.getPath(),
        postfixOnTapped: () {},
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          Space.contentPaddingHorizontal.value,
          Space.contentPaddingTop.value +
              MediaQuery.of(context).viewPadding.top,
          Space.contentPaddingHorizontal.value,
          0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Projects',
              style: textTheme.headlineMedium,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  final project = projects[index];
                  return MyOptionBox(
                    title: project.title,
                    icon: MyIcon.download,
                    onPressed: () => Navigator.of(context).push<void>(
                      ProjectDetailPage.route(
                        projectID: project.id,
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
