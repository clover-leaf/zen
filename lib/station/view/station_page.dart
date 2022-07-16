import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/device/bloc/device_bloc.dart';
import 'package:flutter_firestore/station/station.dart';

class StationPage extends StatelessWidget {
  const StationPage({
    super.key,
    required this.title,
    required this.totalDevice,
  });

  static PageRoute route({
    required String title,
    required int totalDevice,
  }) {
    return MaterialPageRoute<void>(
      builder: (context) => StationPage(
        title: title,
        totalDevice: totalDevice,
      ),
    );
  }

  final String title;
  final int totalDevice;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StationBloc(
        title: title,
        totalDevice: totalDevice,
      ),
      child: const StationView(),
    );
  }
}

class StationView extends StatelessWidget {
  const StationView({super.key});

  @override
  Widget build(BuildContext context) {
    final title = context.select((StationBloc bloc) => bloc.state.title);
    // final totalDevice =
    //     context.select((StationBloc bloc) => bloc.state.totalDevice);
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const NavBar(),
      body: Column(
        children: [
          Header(
            title: title,
            subtitle: 'Devices',
            hasDropdown: true,
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
