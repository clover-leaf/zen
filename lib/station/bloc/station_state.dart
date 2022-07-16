part of 'station_bloc.dart';

enum StationStatus {loading, success}

class StationState extends Equatable {
  const StationState({
    required this.title,
    required this.totalDevice,
    this.status = StationStatus.loading,
  });
  
  final StationStatus status;
  final String title;
  final int totalDevice;
  
  @override
  List<Object> get props => [status, title, totalDevice];
}
