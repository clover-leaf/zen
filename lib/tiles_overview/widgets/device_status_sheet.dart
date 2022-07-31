import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/common/widgets/my_empty_page.dart';
import 'package:flutter_firestore/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_api/iot_api.dart';

class DeviceStatusSheet extends StatelessWidget {
  DeviceStatusSheet({
    super.key,
    required this.project,
    required this.paddingTop,
    required this.deviceView,
    required this.deviceStatusView,
  });

  /// The showed [Project]
  final Project project;

  /// The top padding
  final double paddingTop;

  /// The map of [FieldId] of [Device] and it
  ///
  /// <Device.id, Device>
  final Map<FieldId, Device> deviceView;

  /// The [List] of [Device]
  late final List<Device> devices = deviceView.values.toList();

  /// The map of [Device] with its connection status
  ///
  /// There is a bijection from deviceView to deviceStatusView
  /// When deviceView changes, it also changes
  /// Beside, it only change value of pair when coming payload listened,
  /// but never change its size in this case
  final Map<FieldId, bool?> deviceStatusView;

  /// The [List] of showed [Device]
  late final List<Device> showedDevices = deviceView.values
      .where((device) => device.projectID == project.id)
      .toList();

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
          _Headline(project),
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
              deviceStatusView: deviceStatusView,
            )
        ],
      ),
    );
  }
}

class _Headline extends StatelessWidget {
  const _Headline(this.project);

  final Project project;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.of(context).pop(),
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
                'Connection status',
                style: textTheme.headlineSmall,
              ),
            ],
          ),
          // Text(
          //   project.title,
          //   style: textTheme.titleMedium!.copyWith(
          //     color: const Color(0xff676767),
          //     letterSpacing: 0.8,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class _DeviceList extends StatelessWidget {
  const _DeviceList({
    required this.devices,
    required this.deviceStatusView,
  });

  final List<Device> devices;
  final Map<FieldId, bool?> deviceStatusView;

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
          final status = deviceStatusView[device.id];
          return DeviceLine(
            title: device.name,
            titleStyle: titleStyle,
            subtitle: device.key,
            subtitleStyle: subtitleStyle,
            status: status,
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
    required this.status,
  });

  final String title;
  final TextStyle titleStyle;
  final String subtitle;
  final TextStyle subtitleStyle;
  final bool? status;

  @override
  Widget build(BuildContext context) {
    late String statusLabel;
    late Color statusColor;
    late Color bgColor;
    switch (status) {
      case true:
        statusLabel = 'connected';
        statusColor = const Color(0xff197741);
        bgColor = const Color(0xffe3fcec);
        break;
      case false:
        statusLabel = 'disconnected';
        statusColor = const Color(0xff881b1b);
        bgColor = const Color(0xfff9e5e6);
        break;
      default:
        statusLabel = 'unknown';
        statusColor = const Color(0xff8c6d1f);
        bgColor = const Color(0xfffffcf4);
        break;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Row(
        children: [
          Column(
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
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: bgColor,
                  ),
                  child: Text(
                    statusLabel,
                    style: subtitleStyle.copyWith(
                      color: statusColor,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
