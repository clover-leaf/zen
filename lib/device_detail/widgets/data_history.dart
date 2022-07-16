import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:iot_api/iot_api.dart';

class DataHistory extends StatelessWidget {
  const DataHistory({
    super.key,
    required this.device,
  });

  final Device device;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      color: const Color(0xffffffff),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children:  [
              const DataButton(
                label: 'Import',
                iconData: FontAwesomeIcons.upload,
              ),
              const SizedBox(width: 8),
              const DataButton(
                label: 'Export',
                iconData: FontAwesomeIcons.download,
              ),
              SizedBox(width: Space.contentPaddingLeft.value),
            ],
          ),
          const SizedBox(height: 16),
          const DataTableTitle(),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: 32,
              separatorBuilder: (_, __) => Container(
                height: 2,
                color: const Color(0xfff5f5f5),
              ),
              itemBuilder: (context, index) => DataTicket(
                index: index.toString(),
                timestamp: DateTime(2022, 6, 10, 8).add(
                  Duration(minutes: index * 5),
                ),
                value: 1.2 * index,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DataButton extends StatelessWidget {
  const DataButton({
    super.key,
    required this.label,
    required this.iconData,
  });

  final String label;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Color(0xff225ddd),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            iconData,
            size: 16,
            color: const Color(0xffffffff),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xffffffff),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class DataTableTitle extends StatelessWidget {
  const DataTableTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        left: Space.contentPaddingLeft.value,
        top: 8,
        right: Space.contentPaddingRight.value,
        bottom: 8,
      ),
      decoration: const BoxDecoration(
        color: Color(0xfff5f5f5),
      ),
      child: Row(
        children: [
          Container(
            width: 16,
            alignment: Alignment.centerLeft,
            child: const Text(
              '#',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff183153),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Timestamp',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff183153),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            alignment: Alignment.center,
            width: 48,
            child: const Text(
              'Value',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff183153),
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DataTicket extends StatelessWidget {
  const DataTicket({
    super.key,
    required this.index,
    required this.timestamp,
    required this.value,
  });

  final String index;
  final DateTime timestamp;
  final double value;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        left: Space.contentPaddingLeft.value,
        top: 8,
        right: Space.contentPaddingRight.value,
        bottom: 8,
      ),
      color: const Color(0xffffffff),
      child: Row(
        children: [
          Container(
            width: 16,
            alignment: Alignment.centerLeft,
            child: Text(
              index,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff183153),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                DateFormat('h:mm a  MMMM d, yyyy').format(timestamp),
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff183153),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            alignment: Alignment.center,
            width: 48,
            child: Text(
              value.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff183153),
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
