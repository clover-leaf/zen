part of 'dashboard_detail_bloc.dart';

enum DashboardDetailStatus {loading, success, failure}

class DashboardDetailState extends Equatable {
  const DashboardDetailState({
    required this.project,
    this.status = DashboardDetailStatus.loading,
    this.liveDataGroup = const [[], [], []],
    this.xAxisGridOffset = 0,
  });
  
  final DashboardDetailStatus status;
  final Project project;
  final List<List<LiveData>> liveDataGroup;
  final double xAxisGridOffset;

  DashboardDetailState copyWith({
    DashboardDetailStatus? status,
    Project? project,
    List<List<LiveData>>? liveDataGroup,
    double? xAxisGridOffset,
  }) {
    return DashboardDetailState(
      status: status ?? this.status,
      project: project ?? this.project,
      liveDataGroup: liveDataGroup ?? this.liveDataGroup,
      xAxisGridOffset: xAxisGridOffset ?? this.xAxisGridOffset,
    );
  }

  @override
  List<Object> get props => [project, status, liveDataGroup, xAxisGridOffset];
}
