
import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/widgets/widgets.dart';
import 'package:iot_api/iot_api.dart';

class InfomationTab extends StatelessWidget {
  const InfomationTab({
    super.key,
    required this.device,
  });

  final Device device;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InfoBox(
              title: device.deviceName,
              subtitle: 'Device name',
            ),
            Container(height: 2, color: const Color(0xffe5e5e5)),
            InfoBox(
              title: device.deviceType.getName(),
              subtitle: 'Device type',
            ),
            Container(height: 2, color: const Color(0xffe5e5e5)),
             InfoBox(
              title: device.status.getName(),
              subtitle: 'Status',
            ),
            Container(height: 2, color: const Color(0xffe5e5e5)),
            const InfoBox(
              title: 'Seattle Station',
              subtitle: 'Station',
            ),
            Container(height: 2, color: const Color(0xffe5e5e5)),
            const InfoBox(
              title: 'Project',
              subtitle: 'Project',
            ),
            Container(height: 2, color: const Color(0xffe5e5e5)),
            InfoBox(
              title: device.protocol.getName(),
              subtitle: 'Protocol',
            ),
            Container(height: 2, color: const Color(0xffe5e5e5)),
          ],
        ),
      ),
    );
  }
}
