import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iot_api/iot_api.dart';

class EditHistory extends StatelessWidget {
  const EditHistory({
    super.key,
    required this.device,
  });

  final Device device;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: 12,
      separatorBuilder: (_, __) => const SizedBox(height: 4),
      itemBuilder: (context, index) =>  const EditTicket(),
    );
  }
}

class EditTicket extends StatelessWidget {
  const EditTicket({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      padding: EdgeInsets.only(
        left: Space.contentPaddingLeft.value,
        top: 16,
        right: Space.contentPaddingRight.value,
        bottom: 16,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Color(0xffffffff),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 32,
            width: 32,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: Color(0xff183153),
            ),
            child: const FaIcon(
              FontAwesomeIcons.user,
              size: 12,
              color: Color(0xffffffff),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Change protocol to http',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff183153),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'by Joseph Johnston',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: Color(0xff183153),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.clock,
                    size: 12,
                    color: const Color(0xff183153).withAlpha(193),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Edited at 9:30 AM Jun 10, 2022',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                      color: Color(0xff183153),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
