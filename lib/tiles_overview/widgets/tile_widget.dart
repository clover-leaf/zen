import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/edit_tile/view/edit_tile_page.dart';
import 'package:flutter_firestore/tiles_overview/tiles_overview.dart';
import 'package:flutter_firestore/tiles_overview/widgets/text/text_tile_widget.dart';
import 'package:flutter_firestore/tiles_overview/widgets/toggle/toggle_tile_widget.dart';
import 'package:iot_api/iot_api.dart';

class TileWidget extends StatefulWidget {
  const TileWidget({
    super.key,
    required this.project,
    required this.deviceView,
    required this.tileType,
    required this.tileConfig,
    required this.value,
    required this.width,
  });

  final Project project;
  final Map<FieldId, Device> deviceView;
  final TileType tileType;
  final TileConfig tileConfig;
  final String? value;
  final double width;

  @override
  State<TileWidget> createState() => TileWidgetState();
}

class TileWidgetState extends State<TileWidget> {
  late Offset _tapPostion;

  @override
  Widget build(BuildContext context) {
    late Widget childWidget;
    switch (widget.tileType) {
      case TileType.text:
        childWidget = TextTileWidget(
          tileConfig: widget.tileConfig,
          value: widget.value,
        );
        break;
      case TileType.toggle:
        childWidget = ToggleTileWidget(
          tileConfig: widget.tileConfig,
          value: widget.value,
        );
        break;
    }
    return SizedBox(
      height: 225,
      width: widget.width,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Material(
          color: const Color(0xffb6e1f5).withAlpha(106),
          child: InkWell(
            highlightColor: const Color(0xffb6e1f5).withAlpha(106),
            splashColor: const Color(0xffb6e1f5),
            onTapDown: (detail) {
              setState(() {
                _tapPostion = detail.globalPosition;
              });
            },
            onTap: () => showMenu<EditTileMenuOption>(
              context: context,
              position: RelativeRect.fromRect(
                _tapPostion & const Size(20, 20),
                Offset.zero & MediaQuery.of(context).size,
              ),
              items: [const EditTileEntry()],
            ).then((value) {
              if (value != null) {
                switch (value) {
                  case EditTileMenuOption.edit:
                    Navigator.of(context).push<void>(
                      EditTilePage.route(
                        project: widget.project,
                        tileType: widget.tileType,
                        deviceView: widget.deviceView,
                        initTileConfig: widget.tileConfig,
                      ),
                    );
                    break;
                  case EditTileMenuOption.delete:
                    context.read<TilesOverviewBloc>().add(
                          TileConfigDeleteRequested(
                            widget.tileConfig,
                          ),
                        );
                    break;
                }
              }
            }),
            child: childWidget,
          ),
        ),
      ),
    );
  }
}

class EditTileEntry extends PopupMenuEntry<EditTileMenuOption> {
  const EditTileEntry({
    super.key,
  });

  @override
  double get height => 0;
  // height doesn't matter, as long as we are not giving
  // initialValue to showMenu().

  @override
  bool represents(EditTileMenuOption? value) => false;

  @override
  EditTileEntryState createState() => EditTileEntryState();
}

class EditTileEntryState extends State<EditTileEntry> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: EditTileMenuOption.values
          .map(
            (option) => _OptionButton(
              option: option,
            ),
          )
          .toList(),
    );
  }
}

class _OptionButton extends StatelessWidget {
  const _OptionButton({
    required this.option,
  });

  final EditTileMenuOption option;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(option),
      child: Container(
        width: 128,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        child: Text(option.toTitle()),
      ),
    );
  }
}
