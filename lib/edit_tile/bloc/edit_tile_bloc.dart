import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iot_api/iot_api.dart';
import 'package:user_repository/user_repository.dart';

part 'edit_tile_event.dart';
part 'edit_tile_state.dart';

class EditTileBloc extends Bloc<EditTileEvent, EditTileState> {
  EditTileBloc({
    required this.repository,
    required FieldId projectID,
    required Map<FieldId, Device> deviceView,
    required TileConfig? initTileConfig,
    required TileType tileType,
  }) : super(
          EditTileState(
            projectID: projectID,
            deviceView: deviceView,
            initTileConfig: initTileConfig,
            tileType: tileType,
            tileData: TileData.placeholder(tileType: tileType),
          ),
        ) {
    on<EditTileInitialized>(_onInitialized);
    on<EditTileStatusChanged>(_onStatusChanged);
    on<EditTileTitleChanged>(_onTitleChanged);
    on<EditTileDeviceIdChanged>(_onDeviceIdChanged);
    on<EditTileDataChanged>(_onEditTileDataChanged);
    on<EditTileSubmitted>(_onEditTileSummited);
  }

  final UserRepository repository;

  void _onInitialized(
    EditTileInitialized event,
    Emitter<EditTileState> emit,
  ) {
    if (state.initTileConfig != null) {
      emit(
        state.copyWith(
          status: EditTileStatus.initialized,
          title: state.initTileConfig!.title,
          deviceID: state.initTileConfig!.deviceID,
          tileData: state.initTileConfig!.tileData,
        ),
      );
    } else {
      emit(state.copyWith(status: EditTileStatus.initialized));
    }
  }

  void _onStatusChanged(
    EditTileStatusChanged event,
    Emitter<EditTileState> emit,
  ) {
    emit(state.copyWith(status: event.status));
  }

  void _onTitleChanged(
    EditTileTitleChanged event,
    Emitter<EditTileState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onDeviceIdChanged(
    EditTileDeviceIdChanged event,
    Emitter<EditTileState> emit,
  ) {
    if (state.deviceID == event.deviceID) {
      return;
    }
    final device = state.deviceView[event.deviceID];
    late TileData tileData;
    if (device!.jsonEnable && state.tileData.getFieldId() == null) {
      tileData = state.tileData.setFieldId(device.jsonVariables.first.id);
    } else {
      tileData = state.tileData.setFieldId(null);
    }
    emit(
      state.copyWith(
        deviceID: event.deviceID,
        tileData: tileData,
      ),
    );
  }

  void _onEditTileDataChanged(
    EditTileDataChanged event,
    Emitter<EditTileState> emit,
  ) {
    emit(state.copyWith(tileData: event.tileData));
  }

  Future<void> _onEditTileSummited(
    EditTileSubmitted event,
    Emitter<EditTileState> emit,
  ) async {
    emit(state.copyWith(status: EditTileStatus.saving));
    late TileConfig tileConfig;
    if (state.initTileConfig != null) {
      tileConfig = TileConfig(
        id: state.initTileConfig!.id,
        title: state.title ?? state.initTileConfig!.title,
        deviceID: state.deviceID ?? state.initTileConfig!.deviceID,
        tileType: state.tileType,
        tileData: state.tileData,
      );
    } else {
      tileConfig = TileConfig(
        title: state.title!,
        deviceID: state.deviceID!,
        tileType: state.tileType,
        tileData: state.tileData,
      );
    }
    try {
      await repository.saveTileConfig(tileConfig);
      emit(state.copyWith(status: EditTileStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditTileStatus.failure));
    }
  }
}
