import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:iot_repository/iot_repository.dart';

part 'app_dashboard_event.dart';
part 'app_dashboard_state.dart';

class AppDashboardBloc extends Bloc<AppDashboardEvent, AppDashboardState> {
  AppDashboardBloc({required IotRepository iotRepository})
      : _iotRepository = iotRepository,
        super(
          AppDashboardState(
            spots: List.generate(2, (index) {
              return List.generate(
                31,
                (index) => FlSpot(
                  index.toDouble(),
                  double.parse(
                    (35 + Random().nextDouble() * 20 - 10).toStringAsFixed(1),
                  ),
                ),
              );
            }),
            time: DateTime(2022, 6, 30, 0, 30),
          ),
        ) {
    on<AppDashboardSubcriptionRequested>(_onSubcriptionRequested);
  }

  final IotRepository _iotRepository;

  Future<void> _onSubcriptionRequested(
    AppDashboardSubcriptionRequested event,
    Emitter<AppDashboardState> emit,
  ) async {
    await emit.forEach<List<double>>(
      _iotRepository.fetchLiveData(),
      onData: (data) {
        final newSpots = state.spots
            .map(
              (spot) =>
                  spot.map((value) => FlSpot(value.x - 1, value.y)).toList()
                    ..removeAt(0)
                    ..add(
                      FlSpot(
                        spot.last.x,
                        data[state.spots.indexOf(spot)],
                      ),
                    ),
            )
            .toList();
        final newXAxisOffset = state.xAxisGridOffset + 1;
        if (newXAxisOffset == 10) {
          return state.copyWith(
            spots: newSpots,
            xAxisGridOffset: newXAxisOffset.remainder(10),
            time: state.time.add(const Duration(minutes: 15)),
          );
        } else {
          return state.copyWith(
            spots: newSpots,
            xAxisGridOffset: newXAxisOffset,
          );
        }
      },
      onError: (_, __) => state.copyWith(status: AppDashboardStatus.failure),
    );
  }
}
