import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/device_overview/device_overview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iot_repository/iot_repository.dart';

class DeviceOverviewPage extends StatelessWidget {
  const DeviceOverviewPage({super.key});

  static PageRoute route() {
    return MaterialPageRoute<void>(
      builder: (context) => const DeviceOverviewPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DeviceOverviewBloc(repository: context.read<IotRepository>())
            ..add(const DeviceOverviewFetched()),
      child: const DeviceOverviewView(),
    );
  }
}

class DeviceOverviewView extends StatelessWidget {
  const DeviceOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffffffff),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          0,
          Space.contentPaddingTop.value +
              MediaQuery.of(context).viewPadding.top,
          0,
          Space.contentPaddingBottom.value,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                Space.contentPaddingLeft.value,
                0,
                Space.contentPaddingRight.value,
                0,
              ),
              child: Column(
                children: const [
                  SearchRow(),
                  SizedBox(height: 16),
                  FilterRow(),
                  SizedBox(height: 16),
                ],
              ),
            ),
            const Expanded(
              child: ColoredBox(
                color: Color(0xfff5f5f5),
                child: CustomScrollView(
                  slivers: [
                    DeviceList(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DeviceList extends StatelessWidget {
  const DeviceList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final status =
        context.select((DeviceOverviewBloc bloc) => bloc.state.status);
    final devices =
        context.select((DeviceOverviewBloc bloc) => bloc.state.devices);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          switch (status) {
            case DeviceOverviewStatus.initial:
              return const CircularProgressIndicator();
            case DeviceOverviewStatus.failure:
              return Column(
                children: const [Text('Something wrong')],
              );
            case DeviceOverviewStatus.success:
              final device = devices[index];
              return DeviceCard(device: device);
          }
        },
        childCount: devices.length,
      ),
    );
  }
}

class FilterRow extends StatelessWidget {
  const FilterRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Name',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xff183153),
          ),
        ),
        const SizedBox(width: 4),
        const FaIcon(
          FontAwesomeIcons.arrowDownAZ,
          size: 18,
          color: Color(0xff183153),
        ),
        const Spacer(),
        Badge(
          badgeColor: const Color(0xffee345f),
          child: const FaIcon(
            FontAwesomeIcons.filter,
            color: Color(0xff183153),
          ),
        ),
      ],
    );
  }
}

class SearchRow extends StatelessWidget {
  const SearchRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.pop(context),
          child: Container(
            alignment: Alignment.center,
            height: 32,
            width: 32,
            child: const FaIcon(
              FontAwesomeIcons.angleLeft,
              color: Color(0xff183153),
            ),
          ),
        ),
        const SizedBox(width: 8),
        const Searchbar(),
        const SizedBox(width: 8),
        Container(
          alignment: Alignment.center,
          height: 32,
          width: 32,
          child: const FaIcon(
            FontAwesomeIcons.plus,
            color: Color(0xff183153),
            size: 22,
          ),
        ),
      ],
    );
  }
}
