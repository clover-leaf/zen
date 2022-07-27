// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/edit_tile/edit_tile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

class EditTilePage extends StatelessWidget {
  const EditTilePage({
    super.key,
  });

  static Route route({
    required TileType tileType,
    required Map<FieldId, Device> deviceView,
    required TileConfig? initTileConfig,
  }) {
    return PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
        create: (_) => EditTileBloc(
          repository: context.read<IotRepository>(),
          deviceView: deviceView,
          initTileConfig: initTileConfig,
          tileType: tileType,
        )..add(const EditTileInitialized()),
        child: const EditTilePage(),
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
    return BlocListener<EditTileBloc, EditTileState>(
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
              .read<EditTileBloc>()
              .add(const EditTileStatusChanged(EditTileStatus.initialized));
        }
      },
      child: const EditTileView(),
    );
  }
}

class EditTileView extends StatelessWidget {
  const EditTileView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTileBloc>().state;
    final theme = Theme.of(context);
    final status = state.status;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: MyBottomAppbar(
        prefixIcon: MyIcon.leftButton.getPath(),
        prefixOnTapped: () async {
          if (state.isEditted) {
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
                  context.read<EditTileBloc>().add(const EditTileSubmitted());
                } else {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      MySnackBar.showSnackBar(
                        context: context,
                        content: state.initTileConfig == null
                            ? 'Some fields are empty'
                            : 'No field has edited',
                        snackBarType: SnackBarType.error,
                      ),
                    );
                }
              },
        child: status.isSaving
            ? const CupertinoActivityIndicator()
            : SvgPicture.asset(
                MyIcon.save.getPath(),
                color: const Color(0xffffffff),
              ),
      ),
      body: !status.isInitialized
          ? const Center(child: MyCircularProgress(size: 32))
          : WillPopScope(
              onWillPop: () async {
                if (state.isEditted) {
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
                        const DeviceField(),
                        Divider(
                          indent: Space.contentPaddingHorizontal.value,
                          endIndent: Space.contentPaddingHorizontal.value,
                          height: Space.contentItemGap.value * 2,
                          thickness: Space.globalBorderWidth.value,
                        ),
                        const VariableField(),
                        Divider(
                          indent: Space.contentPaddingHorizontal.value,
                          endIndent: Space.contentPaddingHorizontal.value,
                          height: Space.contentItemGap.value * 2,
                          thickness: Space.globalBorderWidth.value,
                        ),
                        const TileDataField(),
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
    final state = context.watch<EditTileBloc>().state;
    final tileType = state.tileType;
    final initTileConfig = state.initTileConfig;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Space.contentPaddingHorizontal.value,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            initTileConfig == null ? 'Add tile' : 'Edit tile',
            style: textTheme.headlineSmall,
          ),
          Text(
            tileType.toTitle(),
            style: textTheme.titleSmall!.copyWith(
              color: const Color(0xff757575),
            ),
          ),
        ],
      ),
    );
  }
}
