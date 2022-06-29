part of 'app_dashboard_bloc.dart';

enum AppDashboardStatus { loading, success, failure }

class AppDashboardState extends Equatable {
  const AppDashboardState({
    this.status = AppDashboardStatus.loading,
    this.spots = const [],
    this.xAxisGridOffset = 0,
    required this.time,
  });

  final AppDashboardStatus status;
  final List<List<FlSpot>> spots;
  final double xAxisGridOffset;
  final DateTime time;

  AppDashboardState copyWith({
    AppDashboardStatus? status,
    List<List<FlSpot>>? spots,
    double? xAxisGridOffset,
    DateTime? time,
  }) {
    return AppDashboardState(
      status: status ?? this.status,
      spots: spots ?? this.spots,
      xAxisGridOffset: xAxisGridOffset ?? this.xAxisGridOffset,
      time: time ?? this.time,
    );
  }

  @override
  List<Object> get props => [status, spots, xAxisGridOffset, time];
}
