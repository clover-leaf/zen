import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/common/widgets/my_empty_page.dart';
import 'package:flutter_firestore/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_api/iot_api.dart';

class DeviceListSheet extends StatelessWidget {
  DeviceListSheet({
    super.key,
    required this.projectID,
    required this.paddingTop,
    required this.deviceView,
    required this.onTapped,
  });

  /// The ID of showed [Project]
  final FieldId? projectID;

  /// The top padding
  final double paddingTop;

  /// The map of [FieldId] of [Device] and it
  ///
  /// <Device.id, Device>
  final Map<FieldId, Device> deviceView;

  /// The [List] of [Device]
  late final List<Device> devices = deviceView.values.toList();

  /// The [List] of showed [Device]
  late final List<Device> showedDevices = deviceView.values
      .where((device) => device.projectID == projectID)
      .toList();

  /// The update deviceId function
  final Function(FieldId) onTapped;

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
            const Expanded(
              child: MyEmptyPage(
                message: 'There are no devices.'
                    ' \nCreate a new ones to start!',
              ),
            )
          else
            _DeviceList(
              devices: showedDevices,
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
              padding: const EdgeInsets.only(
                right: 12,
              ),
              child: SvgPicture.asset(
                Assets.icons.leftButton,
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
    required this.onTapped,
  });

  final List<Device> devices;
  final Function(FieldId) onTapped;

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
              title: device.name,
              titleStyle: titleStyle,
              subtitle: device.key,
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
