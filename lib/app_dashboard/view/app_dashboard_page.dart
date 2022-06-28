import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/app_dashboard/app_dashboard.dart';

class AppDashboardPage extends StatelessWidget {
  const AppDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppDashboardBloc(),
      child: const AppDashboardView(),
    );
  }
}

class AppDashboardView extends StatelessWidget {
  const AppDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('AppDashboard');
  }
}
