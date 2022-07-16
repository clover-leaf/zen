import 'package:flutter/material.dart';
import 'package:flutter_firestore/device_detail_new/bloc/bloc.dart';

class TabDialog extends StatelessWidget {
  const TabDialog({
    super.key,
    required this.selectedTab,
  });
  final DeviceDetailTab selectedTab;

  @override
  Widget build(BuildContext context) {
    final leftPadding = MediaQuery.of(context).size.width / 2 - 80;

    final topPadding = MediaQuery.of(context).viewPadding.top + 72;

    final rightPadding = MediaQuery.of(context).size.width / 2 - 80;

    final bottomPadding = MediaQuery.of(context).size.height -
        topPadding -
        DeviceDetailTab.values.length * 40;

    return Dialog(
      alignment: Alignment.topCenter,
      insetPadding: EdgeInsets.only(
        left: leftPadding,
        top: topPadding,
        right: rightPadding,
        bottom: bottomPadding,
      ),
      elevation: 0,
      backgroundColor: const Color(0xFFF0F1F2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: DeviceDetailTab.values
            .map(
              (status) => status != selectedTab
                  ? StatusBox(
                      value: status,
                      groupValue: selectedTab,
                    )
                  : const SizedBox(),
            )
            .toList(),
      ),
    );
  }
}

class StatusBox extends StatelessWidget {
  const StatusBox({
    super.key,
    required this.value,
    required this.groupValue,
  });

  final DeviceDetailTab value;
  final DeviceDetailTab groupValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(value),
      child: Container(
        alignment: Alignment.center,
        height: 40,
        color: value == groupValue
            ? const Color(0xffF04243)
            : const Color(0xffF04243),
        child: Text(
          value.getName(),
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: const Color(0xffffffff)),
        ),
      ),
    );
  }
}
