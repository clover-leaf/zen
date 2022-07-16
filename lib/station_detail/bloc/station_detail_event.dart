part of 'station_detail_bloc.dart';

class StationDetailEvent extends Equatable {
  const StationDetailEvent();

  @override
  List<Object> get props => [];
}

class StationDetailTabChanged extends StationDetailEvent {
  const StationDetailTabChanged(this.tab);

  final StationDetailTab tab;

  @override
  List<Object> get props => [tab];
}
