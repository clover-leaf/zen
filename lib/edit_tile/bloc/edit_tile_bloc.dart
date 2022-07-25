import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

part 'edit_tile_event.dart';
part 'edit_tile_state.dart';

class EditTileBloc extends Bloc<EditTileEvent, EditTileState> {
  EditTileBloc({
    required this.repository,
    required Map<FieldId, Broker> brokerView,
    required Map<FieldId, MqttDevice> mqttDeviceView,
    required TileConfig? initTileConfig,
    required TileType tileType,
  }) : super(
          EditTileState(
            brokerView: brokerView,
            mqttDeviceView: mqttDeviceView,
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

  final IotRepository repository;

  void _onInitialized(
    EditTileInitialized event,
    Emitter<EditTileState> emit,
  ) {
    if (state.initTileConfig != null) {
      emit(
        state.copyWith(
          title: state.initTileConfig!.title,
          deviceID: state.initTileConfig!.deviceID,
          tileData: state.initTileConfig!.tileData,
        ),
      );
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
    emit(state.copyWith(deviceID: event.deviceID));
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
        title: state.title,
        deviceID: state.deviceID,
        tileType: state.tileType,
        tileData: state.tileData,
      );
    } else {
      tileConfig = TileConfig(
        title: state.title,
        deviceID: state.deviceID,
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
