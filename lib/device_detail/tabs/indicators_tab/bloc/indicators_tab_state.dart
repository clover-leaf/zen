part of 'indicators_tab_bloc.dart';

enum IndicatorsTabStatus { loading, success, failure }

class IndicatorsTabState extends Equatable {
  const IndicatorsTabState({
    required this.device,
    this.status = IndicatorsTabStatus.loading,
    this.indicators = const <dynamic>[],
  });

  final IndicatorsTabStatus status;
  final Device device;
  final List<dynamic> indicators;

  IndicatorsTabState copyWith({
    IndicatorsTabStatus? status,
    Device? device,
    List<dynamic>? indicators,
  }) =>
      IndicatorsTabState(
        status: status ?? this.status,
        device: device ?? this.device,
        indicators: indicators ?? this.indicators,
      );

  @override
  List<Object> get props => [status, device, indicators];
}
