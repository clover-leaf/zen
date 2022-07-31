import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/common/widgets/widgets.dart';
import 'package:flutter_firestore/edit_project/edit_project.dart';
import 'package:flutter_firestore/gen/assets.gen.dart';
import 'package:flutter_firestore/project_detail/view/view.dart';
import 'package:flutter_firestore/projects_overview/projects_overview.dart';
import 'package:user_repository/user_repository.dart';

class ProjectsOverviewPage extends StatelessWidget {
  const ProjectsOverviewPage({super.key});

  static PageRoute route() {
    return PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
        create: (_) => ProjectsOverviewBloc(
          repository: context.read<UserRepository>(),
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
    final projectView = state.projectView;
    final status = state.status;
    final projects = state.projects;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MyFloatingButton(
        onPressed: () {
          if (status.isInitialized) {
            Navigator.of(context).push<void>(
              EditProjectPage.route(
                projectView: projectView,
                initProject: null,
              ),
            );
          } else {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                MySnackBar.showSnackBar(
                  context: context,
                  content: 'Initializing...',
                  snackBarType: SnackBarType.error,
                ),
              );
          }
        },
      ),
      bottomNavigationBar: MyBottomAppbar(
        prefixIcon: Assets.icons.leftButton,
        prefixOnTapped: () => Navigator.of(context).pop(),
        postfixIcon: Assets.icons.template,
        postfixOnTapped: () {},
      ),
      body: BlocBuilder<ProjectsOverviewBloc, ProjectsOverviewState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (status.isInitializing) {
            return const MyCircularProgress(size: 24);
          }
          return Padding(
            padding: EdgeInsets.fromLTRB(
              0,
              Space.contentPaddingTop.value +
                  MediaQuery.of(context).viewPadding.top,
              0,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    Space.contentPaddingHorizontal.value,
                    0,
                    Space.contentPaddingHorizontal.value,
                    16,
                  ),
                  child: Text(
                    'Projects',
                    style: textTheme.headlineMedium,
                  ),
                ),
                if (projects.isEmpty)
                  const Expanded(
                    child: MyEmptyPage(
                      message: 'There are no projects.'
                          ' \nCreate a new ones to start!',
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        final project = projects[index];
                        return MyOptionBox(
                          title: project.name,
                          innerPadding: EdgeInsets.symmetric(
                            horizontal: Space.contentPaddingHorizontal.value,
                            vertical: 8,
                          ),
                          onPressed: () => Navigator.of(context).push<void>(
                            ProjectDetailPage.route(
                              projectID: project.id,
                            ),
                          ),
                        );
                      },
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
