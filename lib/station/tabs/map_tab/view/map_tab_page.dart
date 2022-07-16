import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/station/tabs/map_tab/map_tab.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:iot_api/iot_api.dart';
import 'package:latlong2/latlong.dart';

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
        Flexible(
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(station.latitude, station.longitude),
              zoom: 8,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    point: LatLng(station.latitude, station.longitude),
                    builder: (context) => const Icon(Icons.pin_drop),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
