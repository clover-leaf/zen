import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/common/widgets/widgets.dart';
import 'package:flutter_firestore/edit_tile/bloc/edit_tile_bloc.dart';
import 'package:flutter_firestore/gen/assets.gen.dart';
import 'package:iot_api/iot_api.dart';

class ToggleTileDataField extends StatelessWidget {
  const ToggleTileDataField({
    super.key,
    required this.initTileData,
    required this.tileData,
    required this.status,
  });

  final ToggleTileData tileData;
  final ToggleTileData? initTileData;
  final EditTileStatus status;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(
          initText: initTileData?.onLabel ?? tileData.onLabel,
          labelText: 'on label',
          prefixIcon: Assets.icons.textFill,
          horizontalPadding: Space.contentPaddingHorizontal.value,
          enabled: !status.isSaving,
          onChanged: (value) {
            final newTileData = tileData.copyWith(onLabel: value);
            context.read<EditTileBloc>().add(EditTileDataChanged(newTileData));
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: MyTextField(
            initText: initTileData?.onValue ?? tileData.onValue,
            labelText: 'on value',
            prefixIcon: Assets.icons.textFill,
            horizontalPadding: Space.contentPaddingHorizontal.value,
            enabled: !status.isSaving,
            onChanged: (value) {
              final newTileData = tileData.copyWith(onValue: value);
              context
                  .read<EditTileBloc>()
                  .add(EditTileDataChanged(newTileData));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: MyTextField(
            initText: initTileData?.offLabel ?? tileData.offLabel,
            labelText: 'off label',
            prefixIcon: Assets.icons.textFill,
            horizontalPadding: Space.contentPaddingHorizontal.value,
            enabled: !status.isSaving,
            onChanged: (value) {
              final newTileData = tileData.copyWith(offLabel: value);
              context
                  .read<EditTileBloc>()
                  .add(EditTileDataChanged(newTileData));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: MyTextField(
            initText: initTileData?.offValue ?? tileData.offValue,
            labelText: 'off value',
            prefixIcon: Assets.icons.textFill,
            horizontalPadding: Space.contentPaddingHorizontal.value,
            enabled: !status.isSaving,
            onChanged: (value) {
              final newTileData = tileData.copyWith(offValue: value);
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
