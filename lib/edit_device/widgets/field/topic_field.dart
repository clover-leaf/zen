import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/common/widgets/widgets.dart';
import 'package:flutter_firestore/edit_device/bloc/bloc.dart';

class TopicField extends StatelessWidget {
  const TopicField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditDeviceBloc>().state;
    final status = state.status;
    final hintTitle = state.topic;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Space.contentPaddingHorizontal.value,
      ),
      child: MyTextField(
        initText: hintTitle,
        labelText: 'Topic name',
        prefixIcon: MyIcon.tag.getPath(),
        horizontalPadding: 0,
        enabled: !status.isSaving,
        onChanged: (value) =>
            context.read<EditDeviceBloc>().add(EditDeviceTopicChanged(value)),
      ),
    );
  }
}
