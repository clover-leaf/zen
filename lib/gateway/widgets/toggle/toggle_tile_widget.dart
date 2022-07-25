import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/edit_tile/edit_tile.dart';
import 'package:flutter_firestore/gateway/gateway.dart';
import 'package:flutter_firestore/tiles_overview/widgets/toggle/toggle_button.dart';
import 'package:iot_api/iot_api.dart';

class ToggleTileWidget extends StatefulWidget {
  const ToggleTileWidget({
    super.key,
    required this.tileConfig,
    required this.value,
    required this.brokerView,
    required this.mqttDeviceView,
  });

  final TileConfig tileConfig;
  final String? value;
  final Map<FieldId, Broker> brokerView;
  final Map<FieldId, MqttDevice> mqttDeviceView;

  @override
  State<ToggleTileWidget> createState() => _ToggleTileWidgetState();
}

class _ToggleTileWidgetState extends State<ToggleTileWidget> {
  late Offset _tapPostion;

  @override
  Widget build(BuildContext context) {
    final title = widget.tileConfig.title;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Material(
        child: InkWell(
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
                      tileType: TileType.toggle,
                      brokerView: widget.brokerView,
                      mqttDeviceView: widget.mqttDeviceView,
                      initTileConfig: widget.tileConfig,
                    ),
                  );
                  break;
                case EditTileMenuOption.delete:
                  // context.read<GatewayBloc>().add(event);
                  break;
                case EditTileMenuOption.duplicate:
                  // context.read<GatewayBloc>().add(event);
                  break;
              }
            }
          }),
          onTapDown: (detail) {
            setState(() {
              _tapPostion = detail.globalPosition;
            });
          },
          child: Container(
            height: 144,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                color: const Color(0xffd3d3d3),
                width: Space.globalBorderWidth.value,
              ),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(title, style: textTheme.titleMedium),
                ),
                if (widget.value == null)
                  const CircularProgressIndicator()
                else
                  ToggleButton(
                    value: widget.value,
                    tileConfig: widget.tileConfig,
                  )
              ],
            ),
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
