import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_overview_event.dart';
part 'app_overview_state.dart';

class AppOverviewBloc extends Bloc<AppOverviewEvent, AppOverviewState> {
  AppOverviewBloc() : super(const AppOverviewState()) {
    // on<ExamRoomRequested>(_onRequested);
  }

  // Future<void> _onRequested(
  //   ExamRoomRequested event,
  //   Emitter<ExamRoomState> emit,
  // ) async {
  // }
}
