import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/constants/space.dart';
import 'package:iot_api/iot_api.dart';

class TextTileWidget extends StatelessWidget {
  const TextTileWidget({
    super.key,
    required this.tileConfig,
    required this.value,
  });

  final TileConfig tileConfig;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final textTileData = tileConfig.tileData as TextTileData;
    final title = tileConfig.title;
    final prefix = textTileData.prefix;
    final postfix = textTileData.postfix;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Container(
        height: 144,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
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
              Text(
                '$prefix $value $postfix',
                style: textTheme.titleLarge,
              )
          ],
        ),
      ),
    );
  }
}
