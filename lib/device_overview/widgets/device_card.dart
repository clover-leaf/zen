import 'package:flutter/material.dart';
import 'package:flutter_firestore/device_detail/view/device_detail_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:iot_api/iot_api.dart';

class DeviceCard extends StatelessWidget {
  const DeviceCard({super.key, required this.device});

  final Device device;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push<void>(
        context,
        DeviceDetailPage.route(device: device),
      ),
      child: Container(
        height: 96,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: double.infinity,
              width: 96,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xff000046),
                    Color(0xff1cb5e0),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      device.deviceName?.toString() ?? 'Noname',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff183153),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _DeviceTag(tag: device.status.getName()),
                        _DeviceTag(tag: device.protocol.getName()),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.clock,
                          size: 13,
                          color: Color(0xff183153),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat('yMMMMd').format(device.createAt),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xff183153),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const _OptionButton(),
          ],
        ),
      ),
    );
  }
}

class _OptionButton extends StatelessWidget {
  const _OptionButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: double.infinity,
      // padding: const EdgeInsets.all(8),
      alignment: Alignment.topRight,
      child: PopupMenuButton<Widget>(
        padding: EdgeInsets.zero,
        elevation: 2,
        icon: const FaIcon(
          FontAwesomeIcons.ellipsis,
          color: Color(0xff183153),
          size: 20,
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            child: const Text(
              'Edit',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff183153),
              ),
            ),
            onTap: () => Navigator.pop(context),
          ),
          PopupMenuItem(
            child: const Text(
              'Favorite',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff183153),
              ),
            ),
            onTap: () => Navigator.pop(context),
          ),
          PopupMenuItem(
            child: const Text(
              'Delete',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff183153),
              ),
            ),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class _DeviceTag extends StatelessWidget {
  const _DeviceTag({
    required this.tag,
  });

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.center,
          height: 24,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            border: Border.all(color: const Color(0xff183153)),
          ),
          child: Text(
            tag,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xff183153),
            ),
          ),
        ),
      ],
    );
  }
}
