import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/common/widgets/widgets.dart';
import 'package:flutter_firestore/devices_overview/view/devices_overview_page.dart';
import 'package:flutter_firestore/project_detail/project_detail.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({super.key});

  static Route route({
    required FieldId projectID,
  }) {
    return PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
        create: (_) => ProjectDetailBloc(
          projectID: projectID,
          repository: context.read<IotRepository>(),
        )..add(const InitializeRequested()),
        child: const ProjectDetailPage(),
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
    return const ProjectDetailView();
  }
}

class ProjectDetailView extends StatelessWidget {
  const ProjectDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final state = context.watch<ProjectDetailBloc>().state;
    final status = state.status;
    final projectID = state.projectID;
    final project = state.projectView[projectID];

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MyFloatingButton(
        icon: MyIcon.pencil,
        onPressed: () {},
      ),
      bottomNavigationBar: MyBottomAppbar(
        prefixIcon: MyIcon.leftButton.getPath(),
        prefixOnTapped: () => Navigator.of(context).pop(),
        postfixIcon: MyIcon.template.getPath(),
        postfixOnTapped: () {},
      ),
      body: BlocBuilder<ProjectDetailBloc, ProjectDetailState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (status.isInitializing) {
            return const MyCircularProgress(size: 24);
          } else if (status.isError) {
            return Text(
              'Oops, something wrong happened',
              style: textTheme.bodyMedium,
            );
          }
          return Padding(
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
                  project!.title,
                  style: textTheme.headlineMedium,
                ),
                MyOptionBox(
                  title: 'Devices',
                  icon: MyIcon.download,
                  onPressed: () => Navigator.of(context).push<void>(
                    DevicesOverviewPage.route(
                      projectID: projectID,
                    ),
                  ),
                ),
                const Divider(),
                MyOptionBox(
                  title: 'Members',
                  icon: MyIcon.download,
                  onPressed: () {},
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
