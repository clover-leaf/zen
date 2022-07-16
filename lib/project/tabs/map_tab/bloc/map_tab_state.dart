part of 'map_tab_bloc.dart';

class MapTabState extends Equatable {
  const MapTabState({
    required this.project,
  });

  final Project project;

  MapTabState copyWith({
    Project? project,
  }) =>
      MapTabState(
        project: project ?? this.project,
      );

  @override
  List<Object> get props => [project];
}
