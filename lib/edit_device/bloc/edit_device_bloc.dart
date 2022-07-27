import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

part 'edit_device_event.dart';
part 'edit_device_state.dart';

class EditDeviceBloc extends Bloc<EditDeviceEvent, EditDeviceState> {
  EditDeviceBloc({
    required this.repository,
    required Device? initDevice,
    required FieldId projectID,
  }) : super(
          EditDeviceState(
            initDevice: initDevice,
            projectID: projectID,
          ),
        ) {
    on<EditDeviceInitialized>(_onInitialized);
    on<EditDeviceStatusChanged>(_onStatusChanged);
    on<EditDeviceTitleChanged>(_onTitleChanged);
    on<EditDeviceTopicChanged>(_onEditDeviceTopicChanged);
    on<EditDeviceJsonEnableChanged>(_onEditDeviceJsonEnableChanged);
    on<EditDeviceJsonVariableSaved>(_onEditDeviceJsonVariableSaved);
    on<EditDeviceJsonVariableDeleted>(_onEditDeviceJsonVariableDeleted);
    on<EditDeviceSubmitted>(_onEditDeviceSummited);
  }

  final IotRepository repository;

  void _onInitialized(
    EditDeviceInitialized event,
    Emitter<EditDeviceState> emit,
  ) {
    if (state.initDevice != null) {
      emit(
        state.copyWith(
          status: EditDeviceStatus.initialized,
          title: state.initDevice!.title,
          topic: state.initDevice!.topic,
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

  void _onTitleChanged(
    EditDeviceTitleChanged event,
    Emitter<EditDeviceState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onEditDeviceTopicChanged(
    EditDeviceTopicChanged event,
    Emitter<EditDeviceState> emit,
  ) {
    emit(state.copyWith(topic: event.topic));
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
      device = Device(
        id: state.initDevice!.id,
        title: state.title ?? state.initDevice!.title,
        projectID: state.projectID ?? state.initDevice!.projectID,
        topic: state.topic ?? state.initDevice!.topic,
        jsonEnable: state.jsonEnable,
        jsonVariables: state.jsonVariables,
      );
    } else {
      device = Device(
        title: state.title ?? state.initDevice!.title,
        projectID: state.projectID ?? state.initDevice!.projectID,
        topic: state.topic ?? state.initDevice!.topic,
        jsonEnable: state.jsonEnable,
        jsonVariables: state.jsonVariables,
      );
    }
    try {
      await repository.saveDevice(device);
      emit(state.copyWith(status: EditDeviceStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditDeviceStatus.failure));
    }
  }
}
