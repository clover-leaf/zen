part of 'edit_tile_bloc.dart';

class EditTileEvent extends Equatable {
  const EditTileEvent();

  @override
  List<Object> get props => [];
}

class EditTileInitialized extends EditTileEvent {
  const EditTileInitialized();
}

class EditTileStatusChanged extends EditTileEvent {
  const EditTileStatusChanged(this.status);

  final EditTileStatus status;

  @override
  List<Object> get props => [status];
}

class EditTileNameChanged extends EditTileEvent {
  const EditTileNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class EditTileDeviceIdChanged extends EditTileEvent {
  const EditTileDeviceIdChanged(this.deviceID);

  final FieldId deviceID;

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
