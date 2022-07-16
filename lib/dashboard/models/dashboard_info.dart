import 'package:flutter_firestore/common/common.dart';

class DashboardInfo {
  DashboardInfo({
    required this.iconPath,
    required this.name,
    required this.totalStation,
  }) : assert(totalStation >= 0, 'Total device must not be negative');

  final SvgIcon iconPath;
  final String name;
  final int totalStation;

  String get subtitle =>
      totalStation > 1 ? '$totalStation stations' : '$totalStation station';
}
