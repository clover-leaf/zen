import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/tiles_overview/widgets/toggle/toggle_button.dart';
import 'package:iot_api/iot_api.dart';

class ToggleTileWidget extends StatelessWidget {
  const ToggleTileWidget({
    super.key,
    required this.tileConfig,
    required this.value,
  });

  final TileConfig tileConfig;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final title = tileConfig.title;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 144,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(
          color: const Color(0xffd3d3d3),
          width: Space.globalBorderWidth.value,
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(title, style: textTheme.titleMedium),
          ),
          if (value == null)
            const CircularProgressIndicator()
          else
            ToggleButton(
              value: value,
              tileConfig: tileConfig,
            )
        ],
      ),
    );
  }
}
