import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_firestore/dashboard/dashboard.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc({required DashboardInfo info}) : super(ProjectState(info: info)) {
    // on<ExamRoomRequested>(_onRequested);
  }

  // Future<void> _onRequested(
  //   ExamRoomRequested event,
  //   Emitter<ExamRoomState> emit,
  // ) async {
  // }
}
