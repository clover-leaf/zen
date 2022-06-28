import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_task_event.dart';
part 'app_task_state.dart';

class AppTaskBloc extends Bloc<AppTaskEvent, AppTaskState> {
  AppTaskBloc() : super(const AppTaskState()) {
    // on<ExamRoomRequested>(_onRequested);
  }

  // Future<void> _onRequested(
  //   ExamRoomRequested event,
  //   Emitter<ExamRoomState> emit,
  // ) async {
  // }
}
