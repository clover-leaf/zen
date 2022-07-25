import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

part 'dashboard_detail_event.dart';
part 'dashboard_detail_state.dart';

double sin2(int dt) => sin(dt / 8 * 2 * pi);
double sin3(int dt) => sin(dt / 12 * 2 * pi);
double sin5(int dt) => sin(dt / 20 * 2 * pi);

double first(int dt) => 20 + sin2(dt) - 2 * sin3(dt) + 4 * sin5(dt);
double second(int dt) => 24 + 2 * sin2(dt) + 3 * sin3(dt) - 3 * sin5(dt);
double third(int dt) => 18 + 3 * sin2(dt) - 2 * sin3(dt) - sin5(dt);

double generate(int index, int dt) {
  switch (index) {
    case 0:
      return first(dt);
    case 1:
      return second(dt);
    case 2:
      return third(dt);
    default:
      return 10;
  }
}

class DashboardDetailBloc
    extends Bloc<DashboardDetailEvent, DashboardDetailState> {
  DashboardDetailBloc({
    required Project project,
    required IotRepository iotRepository,
  })  : _iotRepository = iotRepository,
        super(
          DashboardDetailState(
            project: project,
            liveDataGroup: List.generate(3, (index) {
              return List.generate(
                31,
                (dt) => LiveData(
                  double.parse(
                    (generate(index, dt)).toStringAsFixed(1),
                  ),
                  DateTime(2022, 6, 29).add(Duration(minutes: dt)),
                ),
              );
            }),
          ),
        ) {
    on<DashboardDetailSubcriptionRequested>(_onSubcriptionRequested);
  }

  final IotRepository _iotRepository;

  Future<void> _onSubcriptionRequested(
    DashboardDetailSubcriptionRequested event,
    Emitter<DashboardDetailState> emit,
  ) async {
    await emit.forEach<List<LiveData>>(
      _iotRepository.fetchLiveData(),
      onData: (data) {
        final newLiveDataGroup = List.generate(
          state.liveDataGroup.length,
          (index) => state.liveDataGroup[index]
            ..removeAt(0)
            ..add(data[index]),
        );
        final newXAxisOffset = (state.xAxisGridOffset + 1)
            .remainder(newLiveDataGroup.first.length - 1);
        return state.copyWith(
          liveDataGroup: newLiveDataGroup,
          xAxisGridOffset: newXAxisOffset,
          status: DashboardDetailStatus.success,
        );
      },
      onError: (_, __) => state.copyWith(status: DashboardDetailStatus.failure),
    );
  }
}
