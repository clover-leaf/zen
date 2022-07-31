import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapBox extends StatelessWidget {
  const MapBox({
    super.key,
    required this.latitude,
    required this.longitude,
    this.zoom = 8,
  });

  final double latitude;
  final double longitude;
  final double zoom;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(latitude, longitude),
          zoom: zoom,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: [
              // Marker(
              //   point: LatLng(latitude, longitude),
              //   builder: (context) => Assets.icons.
              //   SvgPicture.asset(
              //     SvgIcon.pin.getPath(),
              //     color: Theme.of(context).primaryColor,
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }
}
