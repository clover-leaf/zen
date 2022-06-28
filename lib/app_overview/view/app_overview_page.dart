import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/app_overview/app_overview.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/device_overview/view/device_overview_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppOverviewPage extends StatelessWidget {
  const AppOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppOverviewBloc(),
      child: const AppOverviewView(),
    );
  }
}

class AppOverviewView extends StatelessWidget {
  const AppOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
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
              children: const [
                UserButton(),
                SizedBox(width: 16),
                Searchbar(),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              alignment: Alignment.topLeft,
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xff4568dc),
                    Color(0xffb06ab3),
                  ],
                ),
              ),
              // child: Row(
              //   children: const [
              //     FaIcon(
              //       FontAwesomeIcons.bullhorn,
              //       color: Color(0xffffffff),
              //       size: 16,
              //     ),
              //     SizedBox(width: 8),
              //     Text(
              //       'Switch to a Pro plan to get more feature!',
              //       style: TextStyle(
              //         fontSize: 15,
              //         fontWeight: FontWeight.bold,
              //         color: Color(0xffffffff),
              //       ),
              //     ),
              //   ],
              // ),
            ),
            const SizedBox(height: 16),
            const FeaturePart(),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Color(0xffffffff),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeaturePart extends StatelessWidget {
  const FeaturePart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 172,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Color(0xffffffff),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Feature',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff000000),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              FeatureBox(
                text: 'Projects',
                iconData: FontAwesomeIcons.barsProgress,
                onTapped: () {},
              ),
              FeatureBox(
                text: 'Stations',
                iconData: FontAwesomeIcons.towerObservation,
                onTapped: () {},
              ),
              FeatureBox(
                text: 'Devices',
                iconData: FontAwesomeIcons.microchip,
                onTapped: () => Navigator.push<void>(
                  context,
                  DeviceOverviewPage.route(),
                ),
              ),
              FeatureBox(
                text: 'Reports',
                iconData: FontAwesomeIcons.newspaper,
                onTapped: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
