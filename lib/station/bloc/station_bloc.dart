import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'station_event.dart';
part 'station_state.dart';

class StationBloc extends Bloc<StationEvent, StationState> {
  StationBloc({
    required String title,
    required int totalDevice,
  }) : super(
          StationState(
            title: title,
            totalDevice: totalDevice,
          ),
        ) {
    // on<ExamRoomRequested>(_onRequested);
  }

  // Future<void> _onRequested(
  //   ExamRoomRequested event,
  //   Emitter<ExamRoomState> emit,
  // ) async {
  // }
}
