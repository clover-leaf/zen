part of 'workspace_bloc.dart';

enum WorkspaceStatus {loading, success, failure}

class WorkspaceState extends Equatable {
  const WorkspaceState({
    this.status = WorkspaceStatus.loading,
    this.projects = const [],
  });
  
  final WorkspaceStatus status;

  final List<Project> projects;

  WorkspaceState copyWith({
    WorkspaceStatus? status,
    List<Project>? projects,
  }) {
    return WorkspaceState(
      status: status ?? this.status,
      projects: projects ?? this.projects,
    );
  }
  
  @override
  List<Object> get props => [status, projects];
}
