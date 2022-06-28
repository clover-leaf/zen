import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/device_overview/device_overview.dart';

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
      create: (_) => DeviceOverviewBloc(),
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
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          Space.contentPaddingLeft.value,
          Space.contentPaddingTop.value +
              MediaQuery.of(context).viewPadding.top,
          Space.contentPaddingRight.value,
          Space.contentPaddingBottom.value,
        ),
        child: Column(
          children: [
            Row(
              children: const [Searchbar(), Expanded(child: FilterBar())],
            ),
          ],
        ),
      ),
    );
  }
}
