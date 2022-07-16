import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/project/tabs/stations_tab/stations_tab.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

class StationsTabPage extends StatelessWidget {
  const StationsTabPage({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StationsTabBloc(
        repository: context.read<IotRepository>(),
        project: project,
      )..add(const AllStationRequested()),
      child: const StationsTabView(),
    );
  }
}

class StationsTabView extends StatelessWidget {
  const StationsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final stations =
        context.select((StationsTabBloc bloc) => bloc.state.stations);
    final status = context.select((StationsTabBloc bloc) => bloc.state.status);
    switch (status) {
      case StationsTabStatus.loading:
        return const LoadingCircle();
      case StationsTabStatus.failure:
        return const Text('failure');
      case StationsTabStatus.success:
        return ListView.separated(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) => StationBox(
            station: stations[index],
            icon: SvgIcon.gasStation,
          ),
          separatorBuilder: (_, __) => const SizedBox(height: 4),
          itemCount: stations.length,
        );
    }
  }
}
