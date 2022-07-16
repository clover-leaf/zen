import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/device/models/device_info.dart';
import 'package:flutter_firestore/device_detail_new/device_detail_new.dart';

class DeviceDetailNewPage extends StatelessWidget {
  const DeviceDetailNewPage({super.key, required this.deviceInfo});

  static PageRoute route({required DeviceInfo deviceInfo}) {
    return MaterialPageRoute<void>(
      builder: (context) => DeviceDetailNewPage(
        deviceInfo: deviceInfo,
      ),
    );
  }

  final DeviceInfo deviceInfo;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DeviceDetailNewBloc(deviceInfo: deviceInfo),
      child: const DeviceDetailNewView(),
    );
  }
}

class DeviceDetailNewView extends StatelessWidget {
  const DeviceDetailNewView({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceInfo =
        context.select((DeviceDetailNewBloc bloc) => bloc.state.deviceInfo);
    final selectedTab =
        context.select((DeviceDetailNewBloc bloc) => bloc.state.tab);
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const NavBar(),
      body: Column(
        children: [
          Header(
            title: deviceInfo.name,
            subtitle: selectedTab.getName(),
            hasDropdown: true,
            onDropdownTapped: () => showDialog<DeviceDetailTab>(
              barrierColor: Colors.transparent,
              context: context,
              builder: (context) => TabDialog(
                selectedTab: selectedTab,
              ),
            ).then((tab) {
              if (tab != null && tab != selectedTab) {
                context
                    .read<DeviceDetailNewBloc>()
                    .add(DeviceDetailTabChanged(tab));
              }
            }),
          ),
          Expanded(
            child: LazyLoadIndexedStack(
              index: selectedTab.index,
              children: [
                InfomationTab(deviceInfo: deviceInfo),
                const LocationTab(),
                const IndicatorTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
