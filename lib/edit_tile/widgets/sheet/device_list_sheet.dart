import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_api/iot_api.dart';

class DeviceListSheet extends StatelessWidget {
  DeviceListSheet({
    super.key,
    required this.paddingTop,
    required this.brokerView,
    required this.deviceView,
    required this.onTapped,
  });

  final double paddingTop;

  /// <BrokerID, Broker>
  final Map<FieldId, Broker> brokerView;
  late final List<Broker> brokers = brokerView.values.toList();

  /// <deviceId, Device>
  final Map<FieldId, Device> deviceView;
  late final List<Device> devices = deviceView.values.toList();

  /// update deviceId function
  final Function(String) onTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        Space.contentPaddingHorizontal.value,
        Space.contentPaddingTop.value + paddingTop,
        Space.contentPaddingHorizontal.value,
        24,
      ),
      decoration: const BoxDecoration(
        color: Color(0xffffffff),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Headline(),
          if (devices.isEmpty)
            const Center(
              child: Text(
                'There are no devices in this project',
              ),
            )
          else
            _DeviceList(
              devices: devices,
              brokerView: brokerView,
              onTapped: onTapped,
            )
        ],
      ),
    );
  }
}

class _Headline extends StatelessWidget {
  const _Headline();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: SvgPicture.asset(
                SvgIcon.downArrow.getPath(),
                color: const Color(0xff757575),
              ),
            ),
          ),
          Text(
            'Devices',
            style: textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}

class _DeviceList extends StatelessWidget {
  const _DeviceList({
    required this.devices,
    required this.brokerView,
    required this.onTapped,
  });

  final List<Device> devices;
  final Map<FieldId, Broker> brokerView;
  final Function(String) onTapped;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final titleStyle = textTheme.titleMedium!.copyWith(
      fontWeight: FontWeight.w500,
      letterSpacing: 0.3,
    );
    final subtitleStyle = textTheme.titleSmall!.copyWith(
      color: const Color(0xff757575),
      letterSpacing: 0.5,
    );

    return Expanded(
      child: ListView.separated(
        separatorBuilder: (_, __) => Divider(
          thickness: Space.globalBorderWidth.value,
          height: 48,
        ),
        itemBuilder: (context, index) {
          final device = devices[index];
          return GestureDetector(
            onTap: () {
              onTapped(device.id);
              Navigator.pop(context);
            },
            behavior: HitTestBehavior.opaque,
            child: DeviceLine(
              title: device.title,
              titleStyle: titleStyle,
              subtitle: device.topic,
              subtitleStyle: subtitleStyle,
            ),
          );
        },
        itemCount: devices.length,
      ),
    );
  }
}

class DeviceLine extends StatelessWidget {
  const DeviceLine({
    super.key,
    required this.title,
    required this.titleStyle,
    required this.subtitle,
    required this.subtitleStyle,
  });

  final String title;
  final TextStyle titleStyle;
  final String subtitle;
  final TextStyle subtitleStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              title,
              style: titleStyle,
            ),
          ),
          Text(
            subtitle,
            style: subtitleStyle,
          ),
        ],
      ),
    );
  }
}
