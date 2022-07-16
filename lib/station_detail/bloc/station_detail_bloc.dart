import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iot_api/iot_api.dart';

part 'station_detail_event.dart';
part 'station_detail_state.dart';

class StationDetailBloc extends Bloc<StationDetailEvent, StationDetailState> {
  StationDetailBloc({required Station station})
      : super(StationDetailState(station: station)) {
    on<StationDetailTabChanged>(_tabChanged);
  }

  void _tabChanged(
    StationDetailTabChanged event,
    Emitter<StationDetailState> emit,
  ) {
    emit(state.copyWith(tab: event.tab));
  }
}
