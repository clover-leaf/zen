import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

part 'indicators_tab_event.dart';
part 'indicators_tab_state.dart';

class IndicatorsTabBloc extends Bloc<IndicatorsTabEvent, IndicatorsTabState> {
  IndicatorsTabBloc({
    required Device device,
    required this.repository,
  }) : super(IndicatorsTabState(device: device)) {
    on<AllIndicatorRequested>(_onRequested);
  }

  final IotRepository repository;

  Future<void> _onRequested(
    AllIndicatorRequested event,
    Emitter<IndicatorsTabState> emit,
  ) async {}
  //   try {
  //     final devices =
  //         await 
  //        repository.getAllDeviceInStation(stationId: state.station.id);
  //     emit(
  //       state.copyWith(
  //         status: IndicatorsTabStatus.success,
  //         devices: devices,
  //       ),
  //     );zr
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //     emit(state.copyWith(status: IndicatorsTabStatus.failure));
  //   }
  // }
}
