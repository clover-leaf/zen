import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iot_api/iot_api.dart';

part 'map_tab_event.dart';
part 'map_tab_state.dart';

class MapTabBloc extends Bloc<MapTabEvent, MapTabState> {
  MapTabBloc({required Station station}) : super(MapTabState(station: station));
}
