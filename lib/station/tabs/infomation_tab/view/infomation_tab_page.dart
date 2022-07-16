import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/station/tabs/infomation_tab/infomation_tab.dart';
import 'package:intl/intl.dart';
import 'package:iot_api/iot_api.dart';

class InfomationTabPage extends StatelessWidget {
  const InfomationTabPage({super.key, required this.station});

  final Station station;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InfomationTabBloc(station: station),
      child: const InfomationTabView(),
    );
  }
}

class InfomationTabView extends StatelessWidget {
  const InfomationTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final station =
        context.select((InfomationTabBloc bloc) => bloc.state.station);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoBox(title: station.stationName, subtitle: 'Name'),
          InfoBox(title: station.phoneNumber, subtitle: 'Phone number'),
          InfoBox(
            title: station.qualityScore.toString(),
            subtitle: 'Quality Score',
          ),
          InfoBox(title: station.city, subtitle: 'City'),
          InfoBox(title: station.ward, subtitle: 'Ward'),
          InfoBox(
            title: DateFormat('yMMMMd').format(station.createAt),
            subtitle: 'Create at',
          ),
        ],
      ),
    );
  }
}
