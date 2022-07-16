part of 'station_detail_bloc.dart';

enum StationDetailStatus { initial, success, failure }

enum StationDetailTab { overview, history, location}

extension StationDetailTabX on StationDetailTab {
  String getName() {
    switch (this) {
      case StationDetailTab.overview:
        return 'OVERVIEW';
      case StationDetailTab.history:
        return 'HISTORY';
      case StationDetailTab.location:
        return 'LOCATION';
    }
  }
}

class StationDetailState extends Equatable {
  const StationDetailState({
    this.status = StationDetailStatus.success,
    this.tab = StationDetailTab.overview,
    required this.station,
  });

  final StationDetailStatus status;
  final StationDetailTab tab;
  final Station station;

  StationDetailState copyWith({
    StationDetailStatus? status,
    StationDetailTab? tab,
    Station? station,
  }) {
    return StationDetailState(
      status: status ?? this.status,
      tab: tab ?? this.tab,
      station: station ?? this.station,
    );
  }

  @override
  List<Object> get props => [status, tab, station];
}
