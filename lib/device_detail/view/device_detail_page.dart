import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/device_detail/device_detail.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iot_api/iot_api.dart';

class DeviceDetailPage extends StatelessWidget {
  const DeviceDetailPage({super.key, required this.device});

  static PageRoute route({required Device device}) {
    return MaterialPageRoute<void>(
      builder: (context) => DeviceDetailPage(
        device: device,
      ),
    );
  }

  final Device device;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DeviceDetailBloc(device: device),
      child: const DeviceDetailView(),
    );
  }
}

class DeviceDetailView extends StatelessWidget {
  const DeviceDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((DeviceDetailBloc bloc) => bloc.state.status);
    final device = context.select((DeviceDetailBloc bloc) => bloc.state.device);
    final tab = context.select((DeviceDetailBloc bloc) => bloc.state.tab);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff5f5f5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(
            title: device.deviceName,
            tabButtonWidth: (MediaQuery.of(context).size.width -
                    Space.contentPaddingLeft.value -
                    Space.contentPaddingRight.value) /
                DeviceDetailTab.values.length,
            tab: tab,
          ),
          const SizedBox(height: 8),
          if (status == DeviceDetailStatus.initial)
            const Center(child: CircularProgressIndicator())
          else
            Expanded(
              child: LazyLoadIndexedStack(
                index: tab.index,
                children: [
                  DeviceInfo(device: device),
                  EditHistory(device: device),
                  DataHistory(device: device),
                  IndicatorList(device: device),
                ],
              ),
            )
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header(
      {required this.title, required this.tabButtonWidth, required this.tab,});

  final String title;
  final double tabButtonWidth;
  final DeviceDetailTab tab;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffffffff),
      padding: EdgeInsets.fromLTRB(
        Space.contentPaddingLeft.value,
        Space.contentPaddingTop.value + MediaQuery.of(context).viewPadding.top,
        Space.contentPaddingRight.value,
        0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  child: const FaIcon(
                    FontAwesomeIcons.angleLeft,
                    color: Color(0xff183153),
                  ),
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xff183153),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const OptionButton()
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _DetailTabButton(
                value: DeviceDetailTab.overview,
                groupValue: tab,
                width: tabButtonWidth,
              ),
              _DetailTabButton(
                value: DeviceDetailTab.history,
                groupValue: tab,
                width: tabButtonWidth,
              ),
              _DetailTabButton(
                value: DeviceDetailTab.data,
                groupValue: tab,
                width: tabButtonWidth,
              ),
              _DetailTabButton(
                value: DeviceDetailTab.indicator,
                groupValue: tab,
                width: tabButtonWidth,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailTabButton extends StatelessWidget {
  const     _DetailTabButton({
    // super.key,
    required this.groupValue,
    required this.value,
    required this.width,
  });

  final DeviceDetailTab groupValue;
  final DeviceDetailTab value;
  final double width;

  @override
  Widget build(BuildContext context) {
    final isSelected = groupValue == value;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () =>
          context.read<DeviceDetailBloc>().add(DeviceDetailTabChanged(value)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        width: width,
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              value.getName(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? const Color(0xff225ddd)
                    : const Color(0xff7a7a7a),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: 24,
              height: 2,
              color: isSelected ? const Color(0xff225ddd) : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
