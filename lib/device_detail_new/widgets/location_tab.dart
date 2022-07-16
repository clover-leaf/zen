import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationTab extends StatelessWidget {
  const LocationTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(10.502307, 107.169205),
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
                point: LatLng(10.762622, 106.660172),
                builder: (context) => const Icon(Icons.pin_drop),
              )
            ],
          )
        ],
      ),
    );
  }
}
