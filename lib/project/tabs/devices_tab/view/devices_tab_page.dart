import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/constants/icons.dart';
import 'package:flutter_firestore/common/widgets/widgets.dart';
import 'package:flutter_firestore/device_detail/device_detail.dart';
import 'package:flutter_firestore/project/tabs/devices_tab/bloc/devices_tab_bloc.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

class DevicesTabPage extends StatelessWidget {
  const DevicesTabPage({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DevicesTabBloc(
        repository: context.read<IotRepository>(),
        project: project,
      )..add(const AllDeviceRequested()),
      child: const DevicesTabView(),
    );
  }
}

class DevicesTabView extends StatelessWidget {
  const DevicesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final devices = context.select((DevicesTabBloc bloc) => bloc.state.devices);
    final status = context.select((DevicesTabBloc bloc) => bloc.state.status);
    switch (status) {
      case DevicesTabStatus.loading:
        return const LoadingCircle();
      case DevicesTabStatus.failure:
        return const Text('failure');
      case DevicesTabStatus.success:
        return ListView.separated(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final device = devices[index];
            return TappableInfoBox(
              title: device.deviceName,
              subtile: device.status.getName(),
              icon: SvgIcon.gasStation,
              onTapped: () => Navigator.push<void>(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => DeviceDetailPage(
                    device: device,
                  ),
                  transitionsBuilder: (c, anim, a2, child) =>
                      FadeTransition(opacity: anim, child: child),
                  transitionDuration: const Duration(milliseconds: 250),
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 4),
          itemCount: devices.length,
        );
    }
  }
}
