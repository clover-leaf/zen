import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_dashboard_event.dart';
part 'app_dashboard_state.dart';

class AppDashboardBloc extends Bloc<AppDashboardEvent, AppDashboardState> {
  AppDashboardBloc() : super(const AppDashboardState()) {
    // on<ExamRoomRequested>(_onRequested);
  }

  // Future<void> _onRequested(
  //   ExamRoomRequested event,
  //   Emitter<ExamRoomState> emit,
  // ) async {
  // }
}
