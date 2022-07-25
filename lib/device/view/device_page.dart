import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/device/device.dart';
import 'package:flutter_firestore/device_detail/view/device_detail_page.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

class DevicePage extends StatelessWidget {
  const DevicePage({super.key});

  static PageRoute route() {
    return MaterialPageRoute<void>(
      builder: (context) => const DevicePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DeviceBloc(
        repository: context.read<IotRepository>(),
      )..add(const GetAllDevice()),
      child: const DeviceView(),
    );
  }
}

class DeviceView extends StatelessWidget {
  const DeviceView({super.key});

  @override
  Widget build(BuildContext context) {
    final devices = context.select((DeviceBloc bloc) => bloc.state.devices);
    final status = context.select((DeviceBloc bloc) => bloc.state.status);
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
            title: 'Devices',
            subtitle: '${devices.length} devices',
            // hasDropdown: true,
            hasBackButton: false,
            // onDropdownTapped: () => showDialog<DeviceStatus>(
            //   barrierColor: Colors.transparent,
            //   context: context,
            //   builder: (context) => StatusDialog(
            //     seletedStatus: seletedStatus,
            //   ),
            // ).then((status) {
            //   if (status != null && status != seletedStatus) {
            //     context.read<DeviceBloc>().add(DeviceStatusChanged(status));
            //   }
            // }),
          ),
          if (status == LoadingStatus.loading)
            const LoadingCircle()
          else if (status == LoadingStatus.failure)
            const Text('Failure')
          else if (status == LoadingStatus.success)
            Expanded(
              child: ListView.separated(
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
                separatorBuilder: (_, __) => Container(
                  color: const Color(0xffe5e5e5),
                  height: 2,
                ),
                itemCount: deviceInfos.length,
              ),
            ),
        ],
      ),
    );
  }
}
