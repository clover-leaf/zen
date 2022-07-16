import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/widgets/widgets.dart';
import 'package:flutter_firestore/device_detail/tabs/indicators_tab/indicators_tab.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

class IndicatorTabPage extends StatelessWidget {
  const IndicatorTabPage({super.key, required this.device});

  final Device device;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => IndicatorsTabBloc(
        repository: context.read<IotRepository>(),
        device: device,
      )..add(const AllIndicatorRequested()),
      child: const IndicatorTabView(),
    );
  }
}

class IndicatorTabView extends StatelessWidget {
  const IndicatorTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final indicators =
        context.select((IndicatorsTabBloc bloc) => bloc.state.indicators);
    final status =
        context.select((IndicatorsTabBloc bloc) => bloc.state.status);
    switch (status) {
      case IndicatorsTabStatus.loading:
        return const LoadingCircle();
      case IndicatorsTabStatus.failure:
        return const Text('failure');
      case IndicatorsTabStatus.success:
        return ListView.separated(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.amber,
              height: 64,
              width: double.infinity,
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 4),
          itemCount: indicators.length,
        );
    }
  }
}
