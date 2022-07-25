import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/widgets/widgets.dart';
import 'package:flutter_firestore/station/tabs/map_tab/map_tab.dart';
import 'package:iot_api/iot_api.dart';

class MapTabPage extends StatelessWidget {
  const MapTabPage({super.key, required this.station});

  final Station station;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapTabBloc(station: station),
      child: const MapTabView(),
    );
  }
}

class MapTabView extends StatelessWidget {
  const MapTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final station = context.select((MapTabBloc bloc) => bloc.state.station);
    return Column(
      children: [
         MapBox(
          latitude: station.latitude,
          longitude: station.longitude,
        ),
      ],
    );
  }
}
