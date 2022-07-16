import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/device_detail/device_detail.dart';
import 'package:iot_api/iot_api.dart';

class DeviceDetailPage extends StatelessWidget {
  const DeviceDetailPage({
    super.key,
    required this.device,
  });

  static PageRoute route({required Device device}) {
    return MaterialPageRoute<void>(
      builder: (context) => DeviceDetailPage(
        device: device,
      ),
    );
  }

  final Device device;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DeviceDetailBloc(device: device),
      child: const DeviceDetailView(),
    );
  }
}

class DeviceDetailView extends StatelessWidget {
  const DeviceDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final device = context.select((DeviceDetailBloc bloc) => bloc.state.device);
    final tab = context.select((DeviceDetailBloc bloc) => bloc.state.tab);
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const NavBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            title: device.deviceName,
            subtitle: device.status.getName(),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                TabButton(
                  label: DeviceDetailTab.infomation.getName(),
                  tab: DeviceDetailTab.infomation,
                  selectedTab: tab,
                  onTapped: () => context
                      .read<DeviceDetailBloc>()
                      .add(const TabChanged(DeviceDetailTab.infomation)),
                ),
                TabButton(
                  label: DeviceDetailTab.indicators.getName(),
                  tab: DeviceDetailTab.indicators,
                  selectedTab: tab,
                  onTapped: () => context
                      .read<DeviceDetailBloc>()
                      .add(const TabChanged(DeviceDetailTab.indicators)),
                ),
              ],
            ),
          ),
          Expanded(
            child: LazyLoadIndexedStack(
              index: tab.index,
              children: [
                InfomationTabPage(device: device),
                IndicatorTabPage(device: device),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
