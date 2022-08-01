import 'package:flutter/material.dart';
import 'package:flutter_firestore/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    final name = tileConfig.name;
    final prefix = textTileData.prefix;
    final postfix = textTileData.postfix;
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
            fit: FlexFit.tight,
            flex: 3,
            child: (value == null)
                ? const CircularProgressIndicator()
                : Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          value!,
                          style: textTheme.headlineLarge!.copyWith(
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                        if (postfix != null) Padding(
                          padding: const EdgeInsets.fromLTRB(4,0,0,4),
                          child: Text(
                            postfix,
                            style: textTheme.titleMedium!.copyWith(
                              color: const Color(0xff676767),
                              fontWeight: FontWeight.w700,
                              height: 1,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: prefix != null
                ? Text(
                    prefix,
                    style: textTheme.titleMedium!.copyWith(
                      color: const Color(0xff676767),
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
