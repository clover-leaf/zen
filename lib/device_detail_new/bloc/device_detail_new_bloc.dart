import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_firestore/device/models/device_info.dart';

part 'device_detail_new_event.dart';
part 'device_detail_new_state.dart';

class DeviceDetailNewBloc
    extends Bloc<DeviceDetailNewEvent, DeviceDetailNewState> {
  DeviceDetailNewBloc({required DeviceInfo deviceInfo})
      : super(DeviceDetailNewState(deviceInfo: deviceInfo)) {
    on<DeviceDetailTabChanged>(_onStatusChanged);
  }

  void _onStatusChanged(
    DeviceDetailTabChanged event,
    Emitter<DeviceDetailNewState> emit,
  ) {
    emit(state.copyWith(tab: event.tab));
  }
}
