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
          children: const [
            UpperPart(),
            Expanded(
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
              return Container(
                height: 120,
                decoration: const BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      '${devices[index].id}',
                      style: const TextStyle(fontSize: 24),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Title',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'subtile',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'subtile',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              );
          }
        },
        childCount: devices.length,
      ),
    );
  }
}

class UpperPart extends StatelessWidget {
  const UpperPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        Space.contentPaddingLeft.value,
        0,
        Space.contentPaddingRight.value,
        0,
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const FaIcon(
                  FontAwesomeIcons.angleLeft,
                  color: Color(0xff878999),
                ),
              ),
              const SizedBox(width: 16),
              const Searchbar(),
              const SizedBox(width: 16),
              const FaIcon(
                FontAwesomeIcons.list,
                color: Color(0xff878999),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Text(
                'Name',
                style: TextStyle(fontSize: 12),
              ),
              Spacer(),
              FaIcon(
                FontAwesomeIcons.filter,
                color: Color(0xff878999),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
