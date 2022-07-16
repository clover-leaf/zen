import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

part 'stations_tab_event.dart';
part 'stations_tab_state.dart';

class StationsTabBloc extends Bloc<StationsTabEvent, StationsTabState> {
  StationsTabBloc({
    required Project project,
    required this.repository,
  }) : super(StationsTabState(project: project)) {
    on<AllStationRequested>(_onRequested);
  }

  final IotRepository repository;

  Future<void> _onRequested(
    AllStationRequested event,
    Emitter<StationsTabState> emit,
  ) async {
    try {
      final stations =
          await repository.getAllStationInProject(projectId: state.project.id);
      emit(
        state.copyWith(
          status: StationsTabStatus.success,
          stations: stations,
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(status: StationsTabStatus.failure));
    }
  }
}
