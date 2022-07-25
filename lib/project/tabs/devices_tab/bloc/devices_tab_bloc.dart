import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

part 'devices_tab_event.dart';
part 'devices_tab_state.dart';

class DevicesTabBloc extends Bloc<DevicesTabEvent, DevicesTabState> {
  DevicesTabBloc({
    required Project project,
    required this.repository,
  }) : super(DevicesTabState(project: project)) {
    on<AllDeviceRequested>(_onRequested);
  }

  final IotRepository repository;

  Future<void> _onRequested(
    AllDeviceRequested event,
    Emitter<DevicesTabState> emit,
  ) async {
    try {
      final devices =
          await repository.getAllDeviceInProject(projectId: state.project.id);
      emit(
        state.copyWith(
          status: DevicesTabStatus.success,
          devices: devices,
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(status: DevicesTabStatus.failure));
    }
  }
}
