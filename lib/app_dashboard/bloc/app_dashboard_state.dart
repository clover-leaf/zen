part of 'app_dashboard_bloc.dart';

enum AppDashboardStatus {loading, success}

class AppDashboardState extends Equatable {
  const AppDashboardState({
    this.status = AppDashboardStatus.loading,
  });
  
  final AppDashboardStatus status;
  
  @override
  List<Object> get props => [status];
}
