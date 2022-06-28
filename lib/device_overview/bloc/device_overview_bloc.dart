import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_firestore/device_overview/device_overview.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

part 'device_overview_event.dart';
part 'device_overview_state.dart';

class DeviceOverviewBloc
    extends Bloc<DeviceOverviewEvent, DeviceOverviewState> {
  DeviceOverviewBloc({required IotRepository repository})
      : _repository = repository,
        super(const DeviceOverviewState()) {
    on<DeviceOverviewFetched>(_onFetched);
  }

  final IotRepository _repository;

  Future<void> _onFetched(
    DeviceOverviewFetched event,
    Emitter<DeviceOverviewState> emit,
  ) async {
    try {
      if (state.status == DeviceOverviewStatus.initial) {
        final _devices = await _repository.fetchDevices();
        return emit(
          state.copyWith(
            status: () => DeviceOverviewStatus.success,
            devices: () => _devices,
          ),
        );
      }
      final _devices =
          await _repository.fetchDevices(start: state.devices.length);
      return emit(
        state.copyWith(
          status: () => DeviceOverviewStatus.success,
          devices: () => state.devices..addAll(_devices),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: () => DeviceOverviewStatus.failure,
        ),
      );
    }
  }
}
