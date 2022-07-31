import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/common/widgets/widgets.dart';
import 'package:flutter_firestore/edit_project/bloc/bloc.dart';
import 'package:flutter_firestore/gen/assets.gen.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditProjectBloc>().state;
    final hintText = state.description;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Space.contentPaddingHorizontal.value,
      ),
      child: MyTextField(
        initText: hintText,
        labelText: 'Project description',
        prefixIcon: Assets.icons.tag,
        horizontalPadding: 0,
        enabled: !state.status.isSaving,
        onChanged: (value) => context
            .read<EditProjectBloc>()
            .add(EditProjectDescriptionChanged(value)),
      ),
    );
  }
}
