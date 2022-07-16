import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/device_detail/tabs/infomation_tab/infomation_tab.dart';
import 'package:intl/intl.dart';
import 'package:iot_api/iot_api.dart';

class InfomationTabPage extends StatelessWidget {
  const InfomationTabPage({super.key, required this.device});

  final Device device;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InfomationTabBloc(device: device),
      child: const InfomationTabView(),
    );
  }
}

class InfomationTabView extends StatelessWidget {
  const InfomationTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final device =
        context.select((InfomationTabBloc bloc) => bloc.state.device);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoBox(title: device.deviceName, subtitle: 'Name'),
          InfoBox(title: device.protocol.getName(), subtitle: 'Protocol'),
          InfoBox(
            title: device.deviceType.getName(),
            subtitle: 'Device type',
          ),
          InfoBox(title: device.serialNumber, subtitle: 'Serial number'),
          InfoBox(title: device.status.getName(), subtitle: 'Status'),
          InfoBox(
            title: DateFormat('yMMMMd').format(device.createAt),
            subtitle: 'Create at',
          ),
        ],
      ),
    );
  }
}
