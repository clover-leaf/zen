import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/app_notification/app_notification.dart';

class AppNotificationPage extends StatelessWidget {
  const AppNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppNotificationBloc(),
      child: const AppNotificationView(),
    );
  }
}

class AppNotificationView extends StatelessWidget {
  const AppNotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('AppNotification');
  }
}
