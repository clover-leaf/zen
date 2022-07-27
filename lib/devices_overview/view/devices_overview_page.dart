import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/common/widgets/widgets.dart';
import 'package:flutter_firestore/devices_overview/devices_overview.dart';
import 'package:flutter_firestore/edit_device/edit_device.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

class DevicesOverviewPage extends StatelessWidget {
  const DevicesOverviewPage({super.key});

  static PageRoute route({
    required FieldId projectID,
  }) {
    return PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
        create: (_) => DevicesOverviewBloc(
          projectID: projectID,
          repository: context.read<IotRepository>(),
        )..add(const InitializeRequested()),
        child: const DevicesOverviewPage(),
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
    return const DevicesOverviewView();
  }
}

class DevicesOverviewView extends StatelessWidget {
  const DevicesOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final state = context.watch<DevicesOverviewBloc>().state;
    final projectID = state.projectID;
    final showedDevices = state.showedDevices;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MyFloatingButton(
        onPressed: () => Navigator.of(context).push<void>(
          EditDevicePage.route(
            projectID: projectID,
            initDevice: null,
          ),
        ),
      ),
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
              'Devices',
              style: textTheme.headlineMedium,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: showedDevices.length,
                itemBuilder: (context, index) {
                  final device = showedDevices[index];
                  return MyOptionBox(
                    title: device.title,
                    icon: MyIcon.download,
                    onPressed: () => Navigator.of(context).push<void>(
                      EditDevicePage.route(
                        projectID: projectID,
                        initDevice: device,
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
