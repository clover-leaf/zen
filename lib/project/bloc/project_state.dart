part of 'project_bloc.dart';

enum ProjectStatus {loading, success}

class ProjectState extends Equatable {
  const ProjectState({
    required this.info,
    this.status = ProjectStatus.loading,
  });
  
  final ProjectStatus status;
  final DashboardInfo info;
  
  @override
  List<Object> get props => [info, status];
}
