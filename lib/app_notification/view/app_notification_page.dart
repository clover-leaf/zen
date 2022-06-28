import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/app_notification/app_notification.dart';
import 'package:flutter_firestore/common/common.dart';

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
    return Padding(
      padding: EdgeInsets.fromLTRB(
        Space.contentPaddingLeft.value,
        Space.contentPaddingTop.value + MediaQuery.of(context).viewPadding.top,
        Space.contentPaddingRight.value,
        Space.contentPaddingBottom.value,
      ),
      child: const Text(
        'Notices',
        style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
      ),
    );
  }
}
