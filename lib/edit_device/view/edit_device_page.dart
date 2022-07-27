// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/common/widgets/widgets.dart';
import 'package:flutter_firestore/edit_device/edit_device.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

class EditDevicePage extends StatelessWidget {
  const EditDevicePage({super.key});

  static Route route({
    required FieldId projectID,
    required Device? initDevice,
  }) {
    return PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
        create: (_) => EditDeviceBloc(
          repository: context.read<IotRepository>(),
          projectID: projectID,
          initDevice: initDevice,
        )..add(const EditDeviceInitialized()),
        child: const EditDevicePage(),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0, 1);
        const end = Offset.zero;
        const curve = Curves.ease;
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditDeviceBloc, EditDeviceState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.pop(context);
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              MySnackBar.showSnackBar(
                context: context,
                content: 'Saving not success',
                snackBarType: SnackBarType.error,
              ),
            );
          context
              .read<EditDeviceBloc>()
              .add(const EditDeviceStatusChanged(EditDeviceStatus.initialized));
        }
      },
      child: const EditDeviceView(),
    );
  }
}

class EditDeviceView extends StatelessWidget {
  const EditDeviceView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditDeviceBloc>().state;
    final theme = Theme.of(context);
    final status = state.status;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: MyBottomAppbar(
        prefixIcon: MyIcon.leftButton.getPath(),
        prefixOnTapped: () async {
          if (state.isEdited()) {
            final value = await showDialog<bool>(
                  context: context,
                  builder: (context) => const MyConfirmDialog(),
                ) ??
                false;
            if (value) Navigator.pop(context);
          } else {
            Navigator.pop(context);
          }
        },
        postfixIcon: MyIcon.faq.getPath(),
        postfixOnTapped: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: status.isSaving
            ? theme.primaryColor.withOpacity(0.5)
            : theme.primaryColor,
        onPressed: status.isSaving
            ? null
            : () {
                if (state.isFilled()) {
                  context
                      .read<EditDeviceBloc>()
                      .add(const EditDeviceSubmitted());
                } else {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      MySnackBar.showSnackBar(
                        context: context,
                        content: state.initDevice == null
                            ? 'Some fields are empty'
                            : 'No field has edited',
                        snackBarType: SnackBarType.error,
                      ),
                    );
                }
              },
        child: SvgPicture.asset(
          MyIcon.save.getPath(),
          color: const Color(0xffffffff),
        ),
      ),
      body: !status.isInitialized
          ? const Center(child: MyCircularProgress(size: 24))
          : WillPopScope(
              onWillPop: () async {
                if (state.isEdited()) {
                  final value = await showDialog<bool>(
                        context: context,
                        builder: (context) => const MyConfirmDialog(),
                      ) ??
                      false;
                  return value;
                }
                return true;
              },
              child: CupertinoScrollbar(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: Space.contentPaddingTop.value +
                          MediaQuery.of(context).viewPadding.top,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _Headline(),
                        SizedBox(height: Space.contentItemGap.value),
                        const TitleField(),
                        Divider(
                          height: Space.contentItemGap.value * 2,
                          thickness: Space.globalBorderWidth.value,
                        ),
                        const TopicField(),
                        const JsonVariableField()
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class _Headline extends StatelessWidget {
  const _Headline();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditDeviceBloc>().state;
    final initDevice = state.initDevice;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Space.contentPaddingHorizontal.value,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            initDevice == null ? 'Add device' : 'Edit device',
            style: textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
