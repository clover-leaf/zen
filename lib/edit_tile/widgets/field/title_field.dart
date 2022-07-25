import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/edit_tile/bloc/edit_tile_bloc.dart';
import 'package:flutter_firestore/edit_tile/widgets/widgets.dart';

class TitleField extends StatelessWidget {
  const TitleField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTileBloc>().state;
    final hintTitle = state.initTileConfig?.title;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Space.contentPaddingHorizontal.value,
      ),
      child: Row(
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: const BoxDecoration(
              color: Color(0xff890e4f),
              borderRadius: BorderRadius.all(Radius.circular(28)),
            ),
          ),
          SizedBox(width: Space.contentItemGap.value),
          Expanded(
            child: MyTextField(
              initText: hintTitle,
              labelText: 'Tile name',
              prefixIcon: MyIcon.tag.getPath(),
              horizontalPadding: 0,
              enabled: !state.status.isSaving,
              onChanged: (value) =>
                  context.read<EditTileBloc>().add(EditTileTitleChanged(value)),
            ),
          ),
        ],
      ),
    );
  }
}
