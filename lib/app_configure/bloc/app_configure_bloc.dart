import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_configure_event.dart';
part 'app_configure_state.dart';

class AppConfigureBloc extends Bloc<AppConfigureEvent, AppConfigureState> {
  AppConfigureBloc() : super(const AppConfigureState()) {
    // on<ExamRoomRequested>(_onRequested);
  }

  // Future<void> _onRequested(
  //   ExamRoomRequested event,
  //   Emitter<ExamRoomState> emit,
  // ) async {
  // }
}
