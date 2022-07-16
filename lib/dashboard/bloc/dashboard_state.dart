part of 'dashboard_bloc.dart';

enum DashboardStatus {loading, success}

class DashboardState extends Equatable {
  const DashboardState({
    this.status = DashboardStatus.loading,
  });
  
  final DashboardStatus status;
  
  @override
  List<Object> get props => [status];
}
