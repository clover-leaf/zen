import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/tiles_overview/bloc/bloc.dart';
import 'package:iot_api/iot_api.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({
    super.key,
    required this.value,
    required this.tileConfig,
  });

  final String? value;
  final TileConfig tileConfig;

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool isOn = false;

  bool updateState({
    required String? value,
    required bool oldState,
    required String onValue,
    required String offValue,
  }) {
    if (value == null) {
      return oldState;
    }
    if (value == onValue) {
      return true;
    } else if (value == offValue) {
      return false;
    }
    return oldState;
  }

  @override
  Widget build(BuildContext context) {
    final toggleTileData = widget.tileConfig.tileData as ToggleTileData;
    final onLabel = toggleTileData.onLabel;
    final onValue = toggleTileData.onValue;
    final offLabel = toggleTileData.offLabel;
    final offValue = toggleTileData.offValue;

    isOn = updateState(
      value: widget.value,
      onValue: onValue,
      offValue: offValue,
      oldState: isOn,
    );
    return GestureDetector(
      onTap: () {
        final payload = isOn ? offValue : onValue;
        context.read<TilesOverviewBloc>().add(
              MessagePublishRequested(
                deviceID: widget.tileConfig.deviceID,
                payload: payload,
              ),
            );
      },
      behavior: HitTestBehavior.opaque,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 56,
            width: 128,
            decoration: BoxDecoration(
              color: isOn ? const Color(0xffe3fcec) : const Color(0xfff9e5e6),
              borderRadius: const BorderRadius.all(
                Radius.circular(32),
              ),
            ),
            child: Row(
              children: [
                _Label(
                  label: onLabel,
                  color: const Color(0xff197741),
                ),
                _Label(
                  label: offLabel,
                  color: const Color(0xff881b1b),
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            top: -4,
            left: isOn ? 64 : 0,
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 300),
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: isOn ? const Color(0xff74d99f) : const Color(0xffe46464),
                borderRadius: const BorderRadius.all(
                  Radius.circular(32),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: 64,
      alignment: Alignment.center,
      child: Text(
        label,
        style: textTheme.labelLarge!.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
