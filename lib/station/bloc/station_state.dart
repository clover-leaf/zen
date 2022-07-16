part of 'station_bloc.dart';

enum StationTab {devices, infomation, location}

extension StationTabX on StationTab {
  String getName() {
    switch (this) {
      case StationTab.devices:
        return 'DEVICES';
      case StationTab.infomation:
        return 'INFOMATION';
      case StationTab.location:
        return 'LOCATION';
    }
  }
}

class StationState extends Equatable {
  const StationState({
    required this.station,
    this.tab = StationTab.devices,
  });
  
  final StationTab tab;
  final Station station;

  StationState copyWith({
    StationTab? tab,
    Station? station,
  }) {
    return StationState(
      tab: tab ?? this.tab,
      station: station ?? this.station,
    );
  }
  
  @override
  List<Object> get props => [tab, station];
}
