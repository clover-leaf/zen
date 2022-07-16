
import 'package:flutter/material.dart';
import 'package:flutter_firestore/device/models/models.dart';

class InfomationTab extends StatelessWidget {
  const InfomationTab({
    super.key,
    required this.deviceInfo,
  });

  final DeviceInfo deviceInfo;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InfoBox(
              title: deviceInfo.name,
              subtitle: 'Device name',
            ),
            Container(height: 2, color: const Color(0xffe5e5e5)),
            const InfoBox(
              title: 'Temperature Sensor',
              subtitle: 'Device type',
            ),
            Container(height: 2, color: const Color(0xffe5e5e5)),
            const InfoBox(
              title: 'Inactive',
              subtitle: 'Status',
            ),
            Container(height: 2, color: const Color(0xffe5e5e5)),
            const InfoBox(
              title: 'Seattle Station',
              subtitle: 'Station',
            ),
            Container(height: 2, color: const Color(0xffe5e5e5)),
            InfoBox(
              title: deviceInfo.project,
              subtitle: 'Project',
            ),
            Container(height: 2, color: const Color(0xffe5e5e5)),
            const InfoBox(
              title: 'Protocol',
              subtitle: 'MQTT',
            ),
            Container(height: 2, color: const Color(0xffe5e5e5)),
          ],
        ),
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  const InfoBox({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 32,
        horizontal: 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.headline2,
          )
        ],
      ),
    );
  }
}
