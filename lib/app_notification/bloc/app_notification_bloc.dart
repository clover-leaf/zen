import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_notification_event.dart';
part 'app_notification_state.dart';

class AppNotificationBloc
    extends Bloc<AppNotificationEvent, AppNotificationState> {
  AppNotificationBloc() : super(const AppNotificationState()) {
    // on<ExamRoomRequested>(_onRequested);
  }

  // Future<void> _onRequested(
  //   ExamRoomRequested event,
  //   Emitter<ExamRoomState> emit,
  // ) async {
  // }
}
