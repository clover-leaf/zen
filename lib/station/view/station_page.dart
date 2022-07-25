import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/station/station.dart';
import 'package:iot_api/iot_api.dart';

class StationPage extends StatelessWidget {
  const StationPage({
    super.key,
    required this.station,
  });

  static PageRoute route({
    required Station station,
  }) {
    return MaterialPageRoute<void>(
      builder: (context) => StationPage(
        station: station,
      ),
    );
  }

  final Station station;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StationBloc(station: station),
      child: const StationView(),
    );
  }
}

class StationView extends StatelessWidget {
  const StationView({super.key});

  @override
  Widget build(BuildContext context) {
    final station = context.select((StationBloc bloc) => bloc.state.station);
    final tab = context.select((StationBloc bloc) => bloc.state.tab);
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const NavBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            title: station.stationName,
            subtitle: station.city,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  TabButton(
                    label: StationTab.infomation.getName(),
                    tab: StationTab.infomation,
                    selectedTab: tab,
                    onTapped: () => context
                        .read<StationBloc>()
                        .add(const TabChanged(StationTab.infomation)),
                  ),
                  TabButton(
                    label: StationTab.location.getName(),
                    tab: StationTab.location,
                    selectedTab: tab,
                    onTapped: () => context
                        .read<StationBloc>()
                        .add(const TabChanged(StationTab.location)),
                  ),
                  TabButton(
                    label: StationTab.devices.getName(),
                    tab: StationTab.devices,
                    selectedTab: tab,
                    onTapped: () => context
                        .read<StationBloc>()
                        .add(const TabChanged(StationTab.devices)),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: LazyLoadIndexedStack(
              index: tab.index,
              children: [
                InfomationTabPage(station: station),
                MapTabPage(station: station),
                DevicesTabPage(station: station),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
