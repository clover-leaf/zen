part of 'station_bloc.dart';

class StationEvent extends Equatable {
  const StationEvent();

  @override
  List<Object> get props => [];
}


class TabChanged extends StationEvent {
  const TabChanged(this.tab);

  final StationTab tab;

  @override
  List<Object> get props => [tab];
}
