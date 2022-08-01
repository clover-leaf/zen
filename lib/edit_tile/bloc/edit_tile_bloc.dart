import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iot_api/iot_api.dart';
import 'package:user_repository/user_repository.dart';

part 'edit_tile_event.dart';
part 'edit_tile_state.dart';

class EditTileBloc extends Bloc<EditTileEvent, EditTileState> {
  EditTileBloc({
    required this.repository,
    required Project project,
    required Map<FieldId, Device> deviceView,
    required TileConfig? initTileConfig,
    required TileType tileType,
  }) : super(
          EditTileState(
            project: project,
            deviceView: deviceView,
            initTileConfig: initTileConfig,
            tileType: tileType,
            tileData: TileData.placeholder(tileType: tileType),
          ),
        ) {
    on<EditTileInitialized>(_onInitialized);
    on<EditTileStatusChanged>(_onStatusChanged);
    on<EditTileNameChanged>(_onNameChanged);
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
          name: state.initTileConfig!.name,
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

  void _onNameChanged(
    EditTileNameChanged event,
    Emitter<EditTileState> emit,
  ) {
    emit(state.copyWith(name: event.name));
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
        name: state.name ?? state.initTileConfig!.name,
        deviceID: state.deviceID ?? state.initTileConfig!.deviceID,
        tileType: state.tileType,
        tileData: state.tileData,
      );
      try {
        await repository.updateTileConfig(tileConfig);
        emit(state.copyWith(status: EditTileStatus.success));
      } catch (e) {
        emit(state.copyWith(status: EditTileStatus.failure));
      }
    } else {
      tileConfig = TileConfig(
        name: state.name!,
        deviceID: state.deviceID!,
        tileType: state.tileType,
        tileData: state.tileData,
      );
      try {
        await repository.saveTileConfig(tileConfig);
        emit(state.copyWith(status: EditTileStatus.success));
      } catch (e) {
        emit(state.copyWith(status: EditTileStatus.failure));
      }
    }
  }
}
