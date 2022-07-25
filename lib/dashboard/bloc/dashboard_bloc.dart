import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required this.repository}) : super(const DashboardState()) {
    on<GetAllProject>(_onGetAllProject);
  }
  final IotRepository repository;

  Future<void> _onGetAllProject(
    GetAllProject event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      final totalProject = await repository.countProject();
      final projects = await repository.getNProject(count: totalProject);
      emit(state.copyWith(projects: projects, status: DashboardStatus.success));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(status: DashboardStatus.failure));
    }
  }
}
