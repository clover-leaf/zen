part of 'app_overview_bloc.dart';

enum AppOverviewStatus {loading, success}

class AppOverviewState extends Equatable {
  const AppOverviewState({
    this.status = AppOverviewStatus.loading,
  });
  
  final AppOverviewStatus status;
  
  @override
  List<Object> get props => [status];
}
