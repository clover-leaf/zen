import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/app_task/app_task.dart';
import 'package:flutter_firestore/common/common.dart';

class AppTaskPage extends StatelessWidget {
  const AppTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppTaskBloc(),
      child: const AppTaskView(),
    );
  }
}

class AppTaskView extends StatelessWidget {
  const AppTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        Space.contentPaddingLeft.value,
        Space.contentPaddingTop.value + MediaQuery.of(context).viewPadding.top,
        Space.contentPaddingRight.value,
        Space.contentPaddingBottom.value,
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Text(
                'Tasks',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
