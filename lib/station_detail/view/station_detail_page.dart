import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/station_detail/station_detail.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iot_api/iot_api.dart';

class StationDetailPage extends StatelessWidget {
  const StationDetailPage({super.key, required this.station});

  static PageRoute route({required Station station}) {
    return MaterialPageRoute<void>(
      builder: (context) => StationDetailPage(
        station: station,
      ),
    );
  }

  final Station station;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StationDetailBloc(station: station),
      child: const StationDetailView(),
    );
  }
}

class StationDetailView extends StatelessWidget {
  const StationDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final status =
        context.select((StationDetailBloc bloc) => bloc.state.status);
    final station =
        context.select((StationDetailBloc bloc) => bloc.state.station);
    final tab = context.select((StationDetailBloc bloc) => bloc.state.tab);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff5f5f5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(
            title: station.stationName,
            tabButtonWidth: (MediaQuery.of(context).size.width -
                    Space.contentPaddingLeft.value -
                    Space.contentPaddingRight.value) /
                StationDetailTab.values.length,
            tab: tab,
          ),
          const SizedBox(height: 8),
          if (status == StationDetailStatus.initial)
            const Center(child: CircularProgressIndicator())
          else
            Expanded(
              child: LazyLoadIndexedStack(
                index: tab.index,
                children: [
                  StationInfo(station: station),
                  EditHistory(station: station),
                  LocationMap(station: station),
                ],
              ),
            )
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    required this.tabButtonWidth,
    required this.tab,
  });

  final String title;
  final double tabButtonWidth;
  final StationDetailTab tab;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffffffff),
      padding: EdgeInsets.fromLTRB(
        Space.contentPaddingLeft.value,
        Space.contentPaddingTop.value + MediaQuery.of(context).viewPadding.top,
        Space.contentPaddingRight.value,
        0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  child: const FaIcon(
                    FontAwesomeIcons.angleLeft,
                    color: Color(0xff183153),
                  ),
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xff183153),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const OptionButton()
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: StationDetailTab.values
                .map<_DetailTabButton>(
                  (value) => _DetailTabButton(
                    value: value,
                    groupValue: tab,
                    width: tabButtonWidth,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _DetailTabButton extends StatelessWidget {
  const _DetailTabButton({
    required this.groupValue,
    required this.value,
    required this.width,
  });

  final StationDetailTab groupValue;
  final StationDetailTab value;
  final double width;

  @override
  Widget build(BuildContext context) {
    final isSelected = groupValue == value;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () =>
          context.read<StationDetailBloc>().add(StationDetailTabChanged(value)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        width: width,
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              value.getName(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? const Color(0xff225ddd)
                    : const Color(0xff7a7a7a),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: 24,
              height: 2,
              color: isSelected ? const Color(0xff225ddd) : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
