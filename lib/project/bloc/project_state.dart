part of 'project_bloc.dart';

enum ProjectTab {infomation, location, stations, devices, }

extension ProjectTabX on ProjectTab {
  String getName() {
    switch (this) {
      case ProjectTab.stations:
        return 'STATIONS';
      case ProjectTab.devices:
        return 'DEVICES';
      case ProjectTab.infomation:
        return 'INFO';
      case ProjectTab.location:
        return 'MAP';
    }
  }
}

class ProjectState extends Equatable {
  const ProjectState({
    required this.project,
    this.tab = ProjectTab.infomation,
  });
  
  final ProjectTab tab;
  final Project project;

  ProjectState copyWith({
    ProjectTab? tab,
    Project? project,
  }) {
    return ProjectState(
      tab: tab ?? this.tab,
      project: project ?? this.project,
    );
  }
  
  @override
  List<Object> get props => [tab, project];
}
