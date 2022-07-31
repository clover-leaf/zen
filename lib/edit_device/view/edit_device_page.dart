import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/common/widgets/widgets.dart';
import 'package:flutter_firestore/edit_device/edit_device.dart';
import 'package:flutter_firestore/gen/assets.gen.dart';
import 'package:iot_api/iot_api.dart';
import 'package:user_repository/user_repository.dart';

class EditDevicePage extends StatelessWidget {
  const EditDevicePage({super.key});

  static Route route({
    required Project project,
    required Device? initDevice,
  }) {
    return PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
        create: (_) => EditDeviceBloc(
          repository: context.read<UserRepository>(),
          project: project,
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
    final status = state.status;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: MyBottomAppbar(
        prefixIcon: Assets.icons.leftButton,
        prefixOnTapped: () async {
          if (state.isEdited()) {
            final navigator = Navigator.of(context);
            final value = await showDialog<bool>(
                  context: context,
                  builder: (context) => const MyConfirmDialog(),
                ) ??
                false;
            if (value) navigator.pop();
          } else {
            Navigator.pop(context);
          }
        },
        postfixIcon: Assets.icons.faq,
        postfixOnTapped: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MyFloatingButton(
        icon: Assets.icons.save,
        onPressed: () {
          if (!status.isSaving) {
            if (!state.isFilled()) {
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
            } else if (!state.isLegal()) {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                  MySnackBar.showSnackBar(
                    context: context,
                    content: 'Topic name is illegal',
                    snackBarType: SnackBarType.error,
                  ),
                );
            } else {
              context.read<EditDeviceBloc>().add(const EditDeviceSubmitted());
            }
          }
        },
      ),
      body: BlocBuilder<EditDeviceBloc, EditDeviceState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (status.isInitializing) {
            return const MyCircularProgress(size: 24);
          }
          return WillPopScope(
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
                      const NameField(),
                      Divider(
                        height: Space.contentItemGap.value * 2,
                        thickness: Space.globalBorderWidth.value,
                      ),
                      const KeyField(),
                      const JsonVariableField()
                    ],
                  ),
                ),
              ),
            ),
          );
        },
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
