import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/app_overview/app_overview.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_svg/svg.dart';
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
              children: [
                Container(
                  height: 48,
                  width: 48,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    color: Color(0xffffffff),
                  ),
                  child: const FaIcon(
                    FontAwesomeIcons.solidUser,
                    size: 20,
                    color: Color(0xff7a7a7a),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class FeatureBox extends StatelessWidget {
  const FeatureBox({
    super.key,
    required this.label,
    required this.iconPath,
    required this.onTapped,
  });

  final String label;
  final String iconPath;
  final Function() onTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        height: 96,
        width: 96,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(Space.globalBorderRadius.value),
          ),
          color: const Color(0xFFF0F1F2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              height: 32,
              width: 32,
              color: const Color(0xFF4D4D4D),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF4D4D4D),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
