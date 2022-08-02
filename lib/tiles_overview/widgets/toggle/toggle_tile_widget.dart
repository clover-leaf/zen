import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/widgets/widgets.dart';
import 'package:flutter_firestore/gen/assets.gen.dart';
import 'package:flutter_firestore/tiles_overview/widgets/toggle/toggle_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    final name = tileConfig.name;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Text(
              name,
              style: textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: SvgPicture.asset(
              Assets.icons.lightbulb,
              height: 40,
              width: 40,
            ),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: (value == null)
                  ? Container(
                      alignment: Alignment.center,
                      child: const MyCircularProgress(size: 24),
                    )
                  : ToggleButton(
                      value: value,
                      tileConfig: tileConfig,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
