import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/device/device.dart';

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
      create: (_) => DeviceBloc(),
      child: const DeviceView(),
    );
  }
}

class DeviceView extends StatelessWidget {
  const DeviceView({super.key});

  @override
  Widget build(BuildContext context) {
    final seletedStatus =
        context.select((DeviceBloc bloc) => bloc.state.deviceStatus);
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
            subtitle: seletedStatus.getName(),
            hasDropdown: true,
            hasBackButton: false,
            onDropdownTapped: () => showDialog<DeviceStatus>(
              barrierColor: Colors.transparent,
              context: context,
              builder: (context) => StatusDialog(
                seletedStatus: seletedStatus,
              ),
            ).then((status) {
              if (status != null && status != seletedStatus) {
                context.read<DeviceBloc>().add(DeviceStatusChanged(status));
              }
            }),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final deviceInfo = deviceInfos[index];
                return DeviceBox(deviceInfo: deviceInfo);
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
