import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState()) {
    // on<ExamRoomRequested>(_onRequested);
  }

  // Future<void> _onRequested(
  //   ExamRoomRequested event,
  //   Emitter<ExamRoomState> emit,
  // ) async {
  // }
}
