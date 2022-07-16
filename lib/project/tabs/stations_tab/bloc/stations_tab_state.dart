part of 'stations_tab_bloc.dart';

enum StationsTabStatus { loading, success, failure }

class StationsTabState extends Equatable {
  const StationsTabState({
    required this.project,
    this.status = StationsTabStatus.loading,
    this.stations = const [],
  });

  final StationsTabStatus status;
  final Project project;
  final List<Station> stations;

  StationsTabState copyWith({
    StationsTabStatus? status,
    Project? project,
    List<Station>? stations,
  }) =>
      StationsTabState(
        status: status ?? this.status,
        project: project ?? this.project,
        stations: stations ?? this.stations,
      );

  @override
  List<Object> get props => [status, project, stations];
}
