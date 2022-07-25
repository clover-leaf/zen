// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/edit_tile/edit_tile.dart';
import 'package:flutter_firestore/edit_tile/widgets/field/toggle_tile_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

class EditTilePage extends StatelessWidget {
  const EditTilePage({
    super.key,
  });

  static PageRoute route({
    required TileType tileType,
    required Map<FieldId, Broker> brokerView,
    required Map<FieldId, MqttDevice> mqttDeviceView,
    required TileConfig? initTileConfig,
  }) {
    return MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (_) => EditTileBloc(
          repository: context.read<IotRepository>(),
          brokerView: brokerView,
          mqttDeviceView: mqttDeviceView,
          initTileConfig: initTileConfig,
          tileType: tileType,
        ),
        child: const EditTilePage(),
      ),
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
              .add(const EditTileStatusChanged(EditTileStatus.initial));
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

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: MyBottomAppbar(
        prefixIcon: MyIcon.leftButton.getPath(),
        prefixOnTapped: () async {
          if (state.isEditted) {
            final value = await showDialog<bool>(
                  context: context,
                  builder: (context) => const ConfirmDialog(),
                ) ??
                false;
            if (value) Navigator.pop(context);
          }
        },
        postfixIcon: MyIcon.faq.getPath(),
        postfixOnTapped: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: state.status.isSaving
            ? theme.primaryColor.withOpacity(0.5)
            : theme.primaryColor,
        onPressed: state.status.isSaving
            ? null
            : () {
                if (state.isFilled) {
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
        child: state.status.isSaving
            ? const CupertinoActivityIndicator()
            : SvgPicture.asset(
                MyIcon.save.getPath(),
                color: const Color(0xffffffff),
              ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (state.isEditted) {
            final value = await showDialog<bool>(
                  context: context,
                  builder: (context) => const ConfirmDialog(),
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
                  const _SpecificField(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SpecificField extends StatelessWidget {
  const _SpecificField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTileBloc>().state;

    switch (state.tileType) {
      case TileType.text:
        return TextTileField(
          initTileData: state.initTileConfig?.tileData as TextTileData?,
          tileData: state.tileData as TextTileData,
          status: state.status,
          isEditted: state.isEditted,
        );
      case TileType.toggle:
        return ToggleTileField(
          initTileData: state.initTileConfig?.tileData as ToggleTileData?,
          tileData: state.tileData as ToggleTileData,
          status: state.status,
          isEditted: state.isEditted,
        );
    }
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
