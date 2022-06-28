import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/app_configure/app_configure.dart';

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
    return const Text('AppConfigure');
  }
}
