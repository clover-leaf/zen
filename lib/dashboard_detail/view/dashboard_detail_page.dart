import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/dashboard/dashboard.dart';
import 'package:flutter_firestore/dashboard_detail/dashboard_detail.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

class DashboardDetailPage extends StatelessWidget {
  const DashboardDetailPage({
    super.key,
    required this.info,
  });

  static PageRoute route({required DashboardInfo info}) {
    return MaterialPageRoute<void>(
      builder: (context) => DashboardDetailPage(
        info: info,
      ),
    );
  }

  final DashboardInfo info;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardDetailBloc(
        info: info,
        iotRepository: context.read<IotRepository>(),
      )..add(const DashboardDetailSubcriptionRequested()),
      child: const DashboardDetailView(),
    );
  }
}

const labels = ['Port A', 'Port B', 'Port C'];
const colors = [
  Color(0xff632af2),
  Color(0xffffb3ba),
  Color(0xff578eff),
];

class DashboardDetailView extends StatelessWidget {
  const DashboardDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final liveDataGroup =
        context.select((DashboardDetailBloc bloc) => bloc.state.liveDataGroup);
    final xAxisGridOffset = context.select(
      (DashboardDetailBloc bloc) => bloc.state.xAxisGridOffset,
    );
    final info = context.select((DashboardDetailBloc bloc) => bloc.state.info);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: const CustomDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatingButton(icon: SvgIcon.add,),
      bottomNavigationBar: const NavBar(),
      body: Column(
        children: [
          Header(
            title: info.name,
            subtitle: 'Seattle station',
            trailer: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SvgPicture.asset(
                SvgIcon.more.getPath(),
                color: const Color(0xffffffff),
              ),
            ),
            hasDropdown: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ColoredBox(
                color: const Color(0xffe5e5e5),
                child: Column(
                  children: [
                    _LineChartCard(
                      colors: colors,
                      labels: labels,
                      liveDataGroup: liveDataGroup,
                      xAxisGridOffset: xAxisGridOffset,
                    ),
                    const SizedBox(height: 2),
                    _BarChartCard(
                      colors: colors,
                      labels: labels,
                      liveDataGroup: liveDataGroup,
                      xAxisGridOffset: xAxisGridOffset,
                    ),
                    const SizedBox(height: 2),
                    _PieChartCard(
                      colors: colors,
                      labels: labels,
                      liveDataGroup: liveDataGroup,
                      xAxisGridOffset: xAxisGridOffset,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LineChartCard extends StatelessWidget {
  const _LineChartCard({
    required this.liveDataGroup,
    required this.xAxisGridOffset,
    required this.colors,
    required this.labels,
  });

  final List<List<LiveData>> liveDataGroup;
  final double xAxisGridOffset;
  final List<Color> colors;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return RectangleChartCard(
      title: 'Charging Port Temperature',
      liveValues:
          liveDataGroup.map((liveDatas) => liveDatas.last.value).toList(),
      unit: '°C',
      labels: labels,
      colors: colors,
      chartWidget: LineChartCustom(
        xAxisGridOffset: xAxisGridOffset,
        liveDataGroup: liveDataGroup,
        colors: colors,
      ),
    );
  }
}

class _BarChartCard extends StatelessWidget {
  const _BarChartCard({
    required this.liveDataGroup,
    required this.xAxisGridOffset,
    required this.colors,
    required this.labels,
  });

  final List<List<LiveData>> liveDataGroup;
  final double xAxisGridOffset;
  final List<Color> colors;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return RectangleChartCard(
      title: 'Energy Consumption',
      liveValues: liveDataGroup
          .map(
            (liveDatas) => double.parse(
              (liveDatas.last.value / 12).toStringAsFixed(1),
            ),
          )
          .toList(),
      unit: 'kW',
      labels: labels,
      colors: colors,
      chartWidget: BarChartCustom(
        xAxisGridOffset: xAxisGridOffset,
        liveDataGroup: liveDataGroup,
        colors: colors,
      ),
    );
  }
}

class _PieChartCard extends StatelessWidget {
  const _PieChartCard({
    required this.liveDataGroup,
    required this.xAxisGridOffset,
    required this.colors,
    required this.labels,
  });

  final List<List<LiveData>> liveDataGroup;
  final double xAxisGridOffset;
  final List<Color> colors;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return CircleChartCard(
      title: 'Charging Port Volume',
      liveValues: liveDataGroup
          .map(
            (liveDatas) => double.parse(
              (liveDatas.last.value / 8).toStringAsFixed(1),
            ),
          )
          .toList(),
      unit: 'L',
      labels: labels,
      colors: colors,
      chartWidget: PieChartCustom(
        xAxisGridOffset: xAxisGridOffset,
        liveDataGroup: liveDataGroup,
        colors: colors,
      ),
    );
  }
}
