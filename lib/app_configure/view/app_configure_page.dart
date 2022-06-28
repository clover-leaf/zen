import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/app_configure/app_configure.dart';
import 'package:flutter_firestore/common/common.dart';

class AppConfigurePage extends StatelessWidget {
  const AppConfigurePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppConfigureBloc(),
      child: const AppConfigureView(),
    );
  }
}

class AppConfigureView extends StatelessWidget {
  const AppConfigureView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        Space.contentPaddingLeft.value,
        Space.contentPaddingTop.value + MediaQuery.of(context).viewPadding.top,
        Space.contentPaddingRight.value,
        Space.contentPaddingBottom.value,
      ),
      child: const Text(
        'Setting',
        style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
      ),
    );
  }
}
