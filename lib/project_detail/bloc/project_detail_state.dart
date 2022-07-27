part of 'project_detail_bloc.dart';

enum ProjectDetailStatus {
  initializing,
  initialized,
  error,
}

extension ProjectDetailStatusX on ProjectDetailStatus {
  bool get isInitializing => this == ProjectDetailStatus.initializing;

  bool get isInitialized => this == ProjectDetailStatus.initialized;

  bool get isError => this == ProjectDetailStatus.error;
}

class ProjectDetailState extends Equatable {
  ProjectDetailState({
    this.status = ProjectDetailStatus.initializing,
    required this.projectID,
    this.projectView = const {},
  });

  /// The status of state
  final ProjectDetailStatus status;

  /// The [Project] of page
  final FieldId projectID;

  /// The map of [FieldId] of [Project] and it
  ///
  /// <Project.id, Project>
  final Map<FieldId, Project> projectView;

  /// The list of [Project]
  late final List<Project> projects = projectView.values.toList();

  ProjectDetailState copyWith({
    ProjectDetailStatus? status,
    FieldId? projectID,
    Map<FieldId, Project>? projectView,
  }) =>
      ProjectDetailState(
        status: status ?? this.status,
        projectID: projectID ?? this.projectID,
        projectView: projectView ?? this.projectView,
      );

  @override
  List<Object> get props => [status, projectID, projectView];
}
