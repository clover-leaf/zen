import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iot_api/iot_api.dart';

part 'device_detail_event.dart';
part 'device_detail_state.dart';

class DeviceDetailBloc extends Bloc<DeviceDetailEvent, DeviceDetailState> {
  DeviceDetailBloc({required Device device})
      : super(DeviceDetailState(device: device)) {
    // on<ExamRoomRequested>(_onRequested);
  }

  // Future<void> _onRequested(
  //   ExamRoomRequested event,
  //   Emitter<ExamRoomState> emit,
  // ) async {
  // }
}
