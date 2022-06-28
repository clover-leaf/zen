import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_firestore/device_overview/device_overview.dart';
import 'package:iot_api/iot_api.dart';

part 'device_overview_event.dart';
part 'device_overview_state.dart';

class DeviceOverviewBloc
    extends Bloc<DeviceOverviewEvent, DeviceOverviewState> {
  DeviceOverviewBloc() : super(const DeviceOverviewState()) {
    // on<ExamRoomRequested>(_onRequested);
  }

  // Future<void> _onRequested(
  //   ExamRoomRequested event,
  //   Emitter<ExamRoomState> emit,
  // ) async {
  // }
}
