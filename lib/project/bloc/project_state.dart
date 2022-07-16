part of 'project_bloc.dart';

enum ProjectTab {stations, infomation, location}

extension ProjectTabX on ProjectTab {
  String getName() {
    switch (this) {
      case ProjectTab.stations:
        return 'STATIONS';
      case ProjectTab.infomation:
        return 'INFOMATION';
      case ProjectTab.location:
        return 'LOCATION';
    }
  }
}

class ProjectState extends Equatable {
  const ProjectState({
    required this.project,
    this.tab = ProjectTab.stations,
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
