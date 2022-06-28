part of 'app_task_bloc.dart';

enum AppTaskStatus {loading, success}

class AppTaskState extends Equatable {
  const AppTaskState({
    this.status = AppTaskStatus.loading,
  });
  
  final AppTaskStatus status;
  
  @override
  List<Object> get props => [status];
}
