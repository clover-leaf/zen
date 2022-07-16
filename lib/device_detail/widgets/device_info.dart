import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:iot_api/iot_api.dart';

class DeviceInfo extends StatelessWidget {
  const DeviceInfo({
    super.key,
    required this.device,
  });

  final Device device;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailInfo(
            label: 'Device name',
            value: device.deviceName,
          ),
          DetailInfo(
            label: 'Description',
            value: device.description,
          ),
          DetailInfo(
            label: 'Serial number',
            value: device.serialNumber,
          ),
          DetailInfo(
            label: 'Protocol',
            value: device.protocol.getName(),
          ),
          DetailInfo(
            label: 'Device type',
            value: device.deviceType.getName(),
          ),
          DetailInfo(
            label: 'Device status',
            value: device.status.getName(),
          ),
        ],
      ),
    );
  }
}

class DetailInfo extends StatelessWidget {
  const DetailInfo({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Container(
        width: double.infinity,
        color: const Color(0xffffffff),
        padding: EdgeInsets.only(
          left: Space.contentPaddingLeft.value,
          top: 12,
          right: Space.contentPaddingRight.value,
          bottom: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                color: Color(0xff183153),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff183153),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
