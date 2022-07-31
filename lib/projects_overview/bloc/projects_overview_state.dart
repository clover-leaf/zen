part of 'projects_overview_bloc.dart';

enum ProjectsOverviewStatus {
  initializing,
  initialized,
}

extension ProjectsOverviewStatusX on ProjectsOverviewStatus {
  bool get isInitializing => this == ProjectsOverviewStatus.initializing;

  bool get isInitialized => this == ProjectsOverviewStatus.initialized;
}

class ProjectsOverviewState extends Equatable {
  ProjectsOverviewState({
    this.status = ProjectsOverviewStatus.initializing,
    this.projectView = const {},
  });

  /// The status of state
  final ProjectsOverviewStatus status;

  /// The map of [FieldId] of [Project] and it
  ///
  /// <Project.id, Project>
  final Map<FieldId, Project> projectView;

  /// The list of [Project]
  late final List<Project> projects = projectView.values.toList();

  ProjectsOverviewState copyWith({
    ProjectsOverviewStatus? status,
    Map<FieldId, Project>? projectView,
    Map<FieldId, Device>? deviceView,
  }) =>
      ProjectsOverviewState(
        status: status ?? this.status,
        projectView: projectView ?? this.projectView,
      );

  @override
  List<Object?> get props => [status, projectView];
}
