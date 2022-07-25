import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/edit_tile/bloc/edit_tile_bloc.dart';
import 'package:flutter_firestore/edit_tile/widgets/widgets.dart';
import 'package:iot_api/iot_api.dart';

class ToggleTileField extends StatelessWidget {
  const ToggleTileField({
    super.key,
    required this.initTileData,
    required this.tileData,
    required this.status,
    required this.isEditted,
  });

  final ToggleTileData tileData;
  final ToggleTileData? initTileData;
  final EditTileStatus status;
  final bool isEditted;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(
          initText: initTileData?.onLabel ?? tileData.onLabel,
          labelText: 'on label',
          prefixIcon: MyIcon.textFill.getPath(),
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
            prefixIcon: MyIcon.textFill.getPath(),
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
            prefixIcon: MyIcon.textFill.getPath(),
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
            prefixIcon: MyIcon.textFill.getPath(),
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
        Divider(
          indent: Space.contentPaddingHorizontal.value,
          endIndent: Space.contentPaddingHorizontal.value,
          height: Space.contentItemGap.value,
          thickness: Space.globalBorderWidth.value,
        ),
        OptionLine(
          title: 'Formating output',
          prefixIcon: MyIcon.code.getPath(),
          enabled: !status.isSaving,
          builder: (_) => JsonExtractionSheet(
            isPayload: false,
            // if tile config has editted
            // hint text is tileData's jsonExtraction
            // else initTileData's jsonExtraction
            initJsonExtraction: isEditted
                ? tileData.jsonExtraction
                : initTileData?.jsonExtraction,
            initJsonEnable:
                isEditted ? tileData.jsonEnable : initTileData?.jsonEnable,
            jsonOptionChange: (jsonExtraction, jsonEnable) {
              final newTileData = tileData.copyWith(
                jsonExtraction: jsonExtraction,
                jsonEnable: jsonEnable,
              );
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
