import 'package:fl_chart/src/chart/base/axis_chart/axis_chart_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/app_dashboard/app_dashboard.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iot_repository/iot_repository.dart';

class AppDashboardPage extends StatelessWidget {
  const AppDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppDashboardBloc(
        iotRepository: context.read<IotRepository>(),
      ),
      // ..add(const AppDashboardSubcriptionRequested()),
      child: const AppDashboardView(),
    );
  }
}

class AppDashboardView extends StatelessWidget {
  const AppDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final spots = context.select((AppDashboardBloc bloc) => bloc.state.spots);
    final xAxisGridOffset = context.select(
      (AppDashboardBloc bloc) => bloc.state.xAxisGridOffset,
    );
    final time = context.select((AppDashboardBloc bloc) => bloc.state.time);

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          Space.contentPaddingLeft.value,
          Space.contentPaddingTop.value +
              MediaQuery.of(context).viewPadding.top,
          Space.contentPaddingRight.value,
          Space.contentPaddingBottom.value,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Organic Farm Project',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  height: 32,
                  width: 32,
                  child: const FaIcon(
                    FontAwesomeIcons.rotate,
                    size: 22,
                    color: Color(0xff183153),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  alignment: Alignment.center,
                  height: 32,
                  width: 32,
                  child: const FaIcon(
                    FontAwesomeIcons.sliders,
                    size: 22,
                    color: Color(0xff183153),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: LineChartSample11(
                        spots: spots,
                        xAxisGridOffset: xAxisGridOffset,
                        time: time,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: BarChartSample(),
                    ),
                    _BarChartCard(spots: spots),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: PieChartSample(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BarChartCard extends StatelessWidget {
  const _BarChartCard({
    required this.spots,
  });

  final List<List<FlSpot>> spots;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ChartCard(
        title: 'Energy Consumption',
        liveValues: spots.map((spot) => spot.last.y).toList(),
        unit: 'kW',
        labels: const [
          'Silo A',
          'Silo B',
        ],
        colors: const [
          Color(0xff4af699),
          Color(0xff09bffe),
        ],
        chartWidget: const BarChartCustom(colors: [
          Color(0xff4af699),
          Color(0xff09bffe),
        ],),
      ),
    );
  }
}
