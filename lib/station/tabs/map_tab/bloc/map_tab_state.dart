part of 'map_tab_bloc.dart';

class MapTabState extends Equatable {
  const MapTabState({
    required this.station,
  });

  final Station station;

  MapTabState copyWith({
    Station? station,
  }) =>
      MapTabState(
        station: station ?? this.station,
      );

  @override
  List<Object> get props => [station];
}
