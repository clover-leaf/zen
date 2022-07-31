import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/common/widgets/widgets.dart';
import 'package:flutter_firestore/edit_tile/bloc/edit_tile_bloc.dart';
import 'package:flutter_firestore/gen/assets.gen.dart';
import 'package:iot_api/iot_api.dart';

class TextTileDataField extends StatelessWidget {
  const TextTileDataField({
    super.key,
    required this.initTileData,
    required this.tileData,
    required this.status,
  });

  final TextTileData tileData;
  final TextTileData? initTileData;
  final EditTileStatus status;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(
          initText: initTileData?.prefix ?? tileData.prefix,
          labelText: 'prefix',
          prefixIcon: Assets.icons.textFill,
          horizontalPadding: Space.contentPaddingHorizontal.value,
          enabled: !status.isSaving,
          onChanged: (value) {
            final newTileData = tileData.copyWith(prefix: value);
            context.read<EditTileBloc>().add(EditTileDataChanged(newTileData));
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: MyTextField(
            initText: initTileData?.postfix ?? tileData.postfix,
            labelText: 'postfix',
            prefixIcon: Assets.icons.textFill,
            horizontalPadding: Space.contentPaddingHorizontal.value,
            enabled: !status.isSaving,
            onChanged: (value) {
              final newTileData = tileData.copyWith(postfix: value);
              context
                  .read<EditTileBloc>()
                  .add(EditTileDataChanged(newTileData));
            },
          ),
        ),
      ],
    );
  }
}
