import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_api/iot_api.dart';

class NewTileSheet extends StatelessWidget {
  const NewTileSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.fromLTRB(
        Space.contentPaddingHorizontal.value,
        24,
        Space.contentPaddingHorizontal.value,
        32 + MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              'Standard',
              style: textTheme.bodyLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Text(
              'Simple tiles, can monitor only one value at a time.',
              style: textTheme.bodySmall,
            ),
          ),
          SizedBox(
            height: 88,
            child: Row(
              children: [
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final tileType = TileType.values[index];
                      late String icon;
                      switch (tileType) {
                        case TileType.text:
                          icon = Assets.icons.textSize;
                          break;
                        case TileType.toggle:
                          icon = Assets.icons.toggle;
                          break;
                      }
                      return TileIconBox(
                        tileType: tileType,
                        icon: icon,
                        title: tileType.toTitle(),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemCount: TileType.values.length,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TileIconBox extends StatelessWidget {
  const TileIconBox({
    super.key,
    required this.tileType,
    required this.icon,
    required this.title,
  });

  final TileType tileType;
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () => Navigator.of(context).pop(tileType),
      child: Container(
        height: 88,
        width: 88,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            width: Space.globalBorderWidth.value,
            color: const Color(0xffd3d3d3),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SvgPicture.asset(
                icon,
                color: const Color(0xff676767),
              ),
            ),
            Text(
              title,
              style: textTheme.bodySmall!.copyWith(
                color: const Color(0xff676767),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
