part of 'edit_tile_bloc.dart';

class EditTileEvent extends Equatable {
  const EditTileEvent();

  @override
  List<Object> get props => [];
}

class EditTileStatusChanged extends EditTileEvent {
  const EditTileStatusChanged(this.status);

  final EditTileStatus status;

  @override
  List<Object> get props => [status];
}

class EditTileTitleChanged extends EditTileEvent {
  const EditTileTitleChanged(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

class EditTileDeviceIdChanged extends EditTileEvent {
  const EditTileDeviceIdChanged(this.deviceID);

  final String deviceID;

  @override
  List<Object> get props => [deviceID];
}

class EditTileDataChanged extends EditTileEvent {
  const EditTileDataChanged(this.tileData);

  final TileData tileData;

  @override
  List<Object> get props => [tileData];
}

class EditTileSubmitted extends EditTileEvent {
  const EditTileSubmitted();
}
