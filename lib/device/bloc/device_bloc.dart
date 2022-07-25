import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_firestore/common/constants/icons.dart';
import 'package:flutter_firestore/dashboard/models/dashboard_info.dart';
import 'package:flutter_firestore/device/models/models.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  DeviceBloc({required this.repository}) : super(const DeviceState()) {
    on<DeviceStatusChanged>(_onStatusChanged);
    on<GetAllDevice>(_onGetAllDevice);
  }

  final IotRepository repository;

  void _onStatusChanged(
    DeviceStatusChanged event,
    Emitter<DeviceState> emit,
  ) {
    emit(state.copyWith(deviceStatus: event.status));
  }

  Future<void> _onGetAllDevice(
    GetAllDevice event,
    Emitter<DeviceState> emit,
  ) async {
    try {
      final totalDevices = await repository.countDevice();
      final devices = await repository.getNDevice(count: totalDevices);
      emit(state.copyWith(devices: devices, status: LoadingStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoadingStatus.failure));
    }
  }
}
