import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/common/widgets/widgets.dart';
import 'package:flutter_firestore/devices_overview/devices_overview.dart';
import 'package:flutter_firestore/edit_device/edit_device.dart';
import 'package:flutter_firestore/gen/assets.gen.dart';
import 'package:iot_api/iot_api.dart';
import 'package:user_repository/user_repository.dart';

class DevicesOverviewPage extends StatelessWidget {
  const DevicesOverviewPage({super.key});

  static PageRoute route({
    required FieldId projectID,
  }) {
    return PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
        create: (_) => DevicesOverviewBloc(
          projectID: projectID,
          repository: context.read<UserRepository>(),
        )..add(const InitializeRequested()),
        child: const DevicesOverviewPage(),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1, 0);
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
    return const DevicesOverviewView();
  }
}

class DevicesOverviewView extends StatelessWidget {
  const DevicesOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final state = context.watch<DevicesOverviewBloc>().state;
    final status = state.status;
    final projectID = state.projectID;
    final projectView = state.projectView;
    final showedDevices = state.showedDevices;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MyFloatingButton(
        onPressed: () => Navigator.of(context).push<void>(
          EditDevicePage.route(
            project: projectView[projectID]!,
            initDevice: null,
          ),
        ),
      ),
      bottomNavigationBar: MyBottomAppbar(
        prefixIcon: Assets.icons.leftButton,
        prefixOnTapped: () => Navigator.of(context).pop(),
        postfixIcon: Assets.icons.template,
        postfixOnTapped: () {},
      ),
      body: BlocBuilder<DevicesOverviewBloc, DevicesOverviewState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (status.isInitializing) {
            return const MyCircularProgress(size: 24);
          } else if (status.isError) {
            return Center(
              child: Text(
                'Oops, something wrong happened',
                style: textTheme.bodyMedium!.copyWith(
                  color: const Color(0xff676767),
                ),
              ),
            );
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        projectView[projectID]!.name,
                        style: textTheme.headlineMedium,
                      ),
                      Text(
                        'Devices',
                        style: textTheme.titleMedium!.copyWith(
                          color: const Color(0xff676767),
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
                if (showedDevices.isEmpty)
                  const Expanded(
                    child: MyEmptyPage(
                      message: 'There are no devices.'
                          ' \nCreate a new ones to start!',
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: showedDevices.length,
                      itemBuilder: (context, index) {
                        final device = showedDevices[index];
                        return MyOptionBox(
                          title: device.name,
                          innerPadding: EdgeInsets.symmetric(
                            horizontal: Space.contentPaddingHorizontal.value,
                            vertical: 8,
                          ),
                          onPressed: () => Navigator.of(context).push<void>(
                            EditDevicePage.route(
                              project: projectView[projectID]!,
                              initDevice: device,
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
