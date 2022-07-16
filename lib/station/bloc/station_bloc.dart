import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iot_api/iot_api.dart';

part 'station_event.dart';
part 'station_state.dart';

class StationBloc extends Bloc<StationEvent, StationState> {
  StationBloc({
    required Station station,
  }) : super(StationState(station: station)) {
     on<TabChanged>(_onTabChanged);
  }

  void _onTabChanged(
    TabChanged event,
    Emitter<StationState> emit,
  ) {
    emit(state.copyWith(tab: event.tab));
  }
}
