part of 'dashboard_bloc.dart';

enum DashboardStatus {loading, success, failure}

class DashboardState extends Equatable {
  const DashboardState({
    this.status = DashboardStatus.loading,
    this.projects = const [],
  });
  
  final DashboardStatus status;
  final List<Project> projects;
  
  DashboardState copyWith({
    DashboardStatus? status,
    List<Project>? projects,
  }) {
    return DashboardState(
      status: status ?? this.status,
      projects: projects ?? this.projects,
    );
  }
  
  @override
  List<Object> get props => [status, projects];
}
