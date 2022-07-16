import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:intl/intl.dart';
import 'package:iot_api/iot_api.dart';

class StationInfo extends StatelessWidget {
  const StationInfo({
    super.key,
    required this.station,
  });

  final Station station;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailInfo(
            label: 'Station name',
            value: station.stationName,
          ),
          DetailInfo(
            label: 'Description',
            value: station.description,
          ),
          DetailInfo(
            label: 'Phone number',
            value: station.phoneNumber,
          ),
          DetailInfo(
            label: 'Balance',
            value: station.balance,
          ),
          DetailInfo(
            label: 'Expired date',
            value: DateFormat('yMMMMd').format(station.expiredDate),
          ),
          DetailInfo(
            label: 'Quality score',
            value: station.qualityScore.toString(),
          ),
          DetailInfo(
            label: 'City',
            value: station.city,
          ),
          DetailInfo(
            label: 'District',
            value: station.district,
          ),
          DetailInfo(
            label: 'Ward',
            value: station.ward,
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
