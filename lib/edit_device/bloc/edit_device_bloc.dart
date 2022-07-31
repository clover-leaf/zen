import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iot_api/iot_api.dart';
import 'package:user_repository/user_repository.dart';

part 'edit_device_event.dart';
part 'edit_device_state.dart';

class EditDeviceBloc extends Bloc<EditDeviceEvent, EditDeviceState> {
  EditDeviceBloc({
    required this.repository,
    required Device? initDevice,
    required Project project,
  }) : super(
          EditDeviceState(
            initDevice: initDevice,
            project: project,
          ),
        ) {
    on<EditDeviceInitialized>(_onInitialized);
    on<EditDeviceStatusChanged>(_onStatusChanged);
    on<EditDeviceNameChanged>(_onNameChanged);
    on<EditDeviceJsonEnableChanged>(_onEditDeviceJsonEnableChanged);
    on<EditDeviceJsonVariableSaved>(_onEditDeviceJsonVariableSaved);
    on<EditDeviceJsonVariableDeleted>(_onEditDeviceJsonVariableDeleted);
    on<EditDeviceSubmitted>(_onEditDeviceSummited);
  }

  final UserRepository repository;

  void _onInitialized(
    EditDeviceInitialized event,
    Emitter<EditDeviceState> emit,
  ) {
    if (state.initDevice != null) {
      emit(
        state.copyWith(
          status: EditDeviceStatus.initialized,
          name: state.initDevice!.name,
          jsonEnable: state.initDevice!.jsonEnable,
          jsonVariables: state.initDevice!.jsonVariables,
        ),
      );
    } else {
      emit(state.copyWith(status: EditDeviceStatus.initialized));
    }
  }

  void _onStatusChanged(
    EditDeviceStatusChanged event,
    Emitter<EditDeviceState> emit,
  ) {
    emit(state.copyWith(status: event.status));
  }

  void _onNameChanged(
    EditDeviceNameChanged event,
    Emitter<EditDeviceState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  void _onEditDeviceJsonEnableChanged(
    EditDeviceJsonEnableChanged event,
    Emitter<EditDeviceState> emit,
  ) {
    emit(state.copyWith(jsonEnable: event.jsonEnable));
  }

  void _onEditDeviceJsonVariableSaved(
    EditDeviceJsonVariableSaved event,
    Emitter<EditDeviceState> emit,
  ) {
    final jsonVariables = List<JsonVariable>.from(state.jsonVariables);
    final matchedIdx = jsonVariables
        .indexWhere((jsonVar) => jsonVar.id == event.jsonVariable.id);
    if (matchedIdx == -1) {
      jsonVariables.add(event.jsonVariable);
    } else {
      jsonVariables[matchedIdx] = event.jsonVariable;
    }
    emit(state.copyWith(jsonVariables: jsonVariables));
  }

  void _onEditDeviceJsonVariableDeleted(
    EditDeviceJsonVariableDeleted event,
    Emitter<EditDeviceState> emit,
  ) {
    final jsonVariables = List<JsonVariable>.from(state.jsonVariables);
    final matchedIdx = jsonVariables
        .indexWhere((jsonVar) => jsonVar.id == event.jsonVariable.id);
    if (matchedIdx != -1) {
      jsonVariables.removeAt(matchedIdx);
      emit(state.copyWith(jsonVariables: jsonVariables));
    }
  }

  Future<void> _onEditDeviceSummited(
    EditDeviceSubmitted event,
    Emitter<EditDeviceState> emit,
  ) async {
    emit(state.copyWith(status: EditDeviceStatus.saving));
    late Device device;
    if (state.initDevice != null) {
      device = state.initDevice!.copyWith(
        name: state.name ?? state.initDevice!.name,
        projectID: state.project.id,
        jsonEnable: state.jsonEnable,
        jsonVariables: state.jsonVariables,
      );
      try {
        await repository.updateDevice(
          device,
          state.project.key,
          state.initDevice!.key,
        );
        emit(state.copyWith(status: EditDeviceStatus.success));
      } catch (e) {
        emit(state.copyWith(status: EditDeviceStatus.failure));
      }
    } else {
      device = Device(
        name: state.name!,
        key: state.name!,
        projectID: state.project.id,
        jsonEnable: state.jsonEnable,
        jsonVariables: state.jsonVariables,
      );
      try {
        await repository.saveDevice(device, state.project.key);
        emit(state.copyWith(status: EditDeviceStatus.success));
      } catch (e) {
        emit(state.copyWith(status: EditDeviceStatus.failure));
      }
    }
  }
}
