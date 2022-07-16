part of 'workspace_bloc.dart';

enum WorkspaceStatus {loading, success}

class WorkspaceState extends Equatable {
  const WorkspaceState({
    this.status = WorkspaceStatus.loading,
  });
  
  final WorkspaceStatus status;
  
  @override
  List<Object> get props => [status];
}
