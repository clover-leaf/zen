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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: LineChartSample11(
                        spots: spots,
                        xAxisGridOffset: xAxisGridOffset,
                        time: time,
                      ),
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
