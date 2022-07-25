part of 'station_bloc.dart';

enum StationTab { infomation, location, devices }

extension StationTabX on StationTab {
  String getName() {
    switch (this) {
      case StationTab.infomation:
        return 'INFO';
      case StationTab.location:
        return 'MAP';
      case StationTab.devices:
        return 'DEVICES';
    }
  }
}

class StationState extends Equatable {
  const StationState({
    required this.station,
    this.tab = StationTab.infomation,
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
