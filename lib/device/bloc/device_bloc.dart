import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_firestore/common/constants/icons.dart';
import 'package:flutter_firestore/dashboard/models/dashboard_info.dart';
import 'package:flutter_firestore/device/models/models.dart';

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  DeviceBloc() : super(const DeviceState()) {
    on<DeviceStatusChanged>(_onStatusChanged);
  }

  void _onStatusChanged(
    DeviceStatusChanged event,
    Emitter<DeviceState> emit,
  ) {
    emit(state.copyWith(deviceStatus: event.status));
  }
}
