import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/edit_tile/bloc/bloc.dart';
import 'package:flutter_firestore/edit_tile/widgets/tile_data_field/text_tile_data_field.dart';
import 'package:flutter_firestore/edit_tile/widgets/tile_data_field/toggle_tile_data_field.dart';
import 'package:iot_api/iot_api.dart';

class TileDataField extends StatelessWidget {
  const TileDataField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTileBloc>().state;
    final initTileConfig = state.initTileConfig;
    final tileData = state.tileData;
    final status = state.status;

    switch (state.tileType) {
      case TileType.text:
        return TextTileDataField(
          initTileData: initTileConfig?.tileData as TextTileData?,
          tileData: tileData as TextTileData,
          status: status,
        );
      case TileType.toggle:
        return ToggleTileDataField(
          initTileData: initTileConfig?.tileData as ToggleTileData?,
          tileData: tileData as ToggleTileData,
          status: status,
        );
    }
  }
}
