part of 'app_notification_bloc.dart';

enum AppNotificationStatus {loading, success}

class AppNotificationState extends Equatable {
  const AppNotificationState({
    this.status = AppNotificationStatus.loading,
  });
  
  final AppNotificationStatus status;
  
  @override
  List<Object> get props => [status];
}
