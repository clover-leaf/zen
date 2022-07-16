part of 'dashboard_detail_bloc.dart';

enum DashboardDetailStatus {loading, success, failure}

class DashboardDetailState extends Equatable {
  const DashboardDetailState({
    required this.info,
    this.status = DashboardDetailStatus.loading,
    this.liveDataGroup = const [[], [], []],
    this.xAxisGridOffset = 0,
  });
  
  final DashboardDetailStatus status;
  final DashboardInfo info;
  final List<List<LiveData>> liveDataGroup;
  final double xAxisGridOffset;

  DashboardDetailState copyWith({
    DashboardDetailStatus? status,
    DashboardInfo? info,
    List<List<LiveData>>? liveDataGroup,
    double? xAxisGridOffset,
  }) {
    return DashboardDetailState(
      status: status ?? this.status,
      info: info ?? this.info,
      liveDataGroup: liveDataGroup ?? this.liveDataGroup,
      xAxisGridOffset: xAxisGridOffset ?? this.xAxisGridOffset,
    );
  }

  @override
  List<Object> get props => [info, status, liveDataGroup, xAxisGridOffset];
}
