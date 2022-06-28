part of 'app_configure_bloc.dart';

enum AppConfigureStatus {loading, success}

class AppConfigureState extends Equatable {
  const AppConfigureState({
    this.status = AppConfigureStatus.loading,
  });
  
  final AppConfigureStatus status;
  
  @override
  List<Object> get props => [status];
}
