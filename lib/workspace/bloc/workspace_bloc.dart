import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

part 'workspace_event.dart';
part 'workspace_state.dart';

class WorkspaceBloc extends Bloc<WorkspaceEvent, WorkspaceState> {
  WorkspaceBloc({required this.repository}) : super(const WorkspaceState()) {
    on<GetAllProject>(_onGetAllProject);
  }

  final IotRepository repository;

  Future<void> _onGetAllProject(
    GetAllProject event,
    Emitter<WorkspaceState> emit,
  ) async {
    try {
      final totalProject = await repository.countProject();
      if (kDebugMode) {
        print(totalProject);
      }
      final projects = await repository.getNProject(count: totalProject);
      emit(state.copyWith(projects: projects, status: WorkspaceStatus.success));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(status: WorkspaceStatus.failure));
    }
  }
}
