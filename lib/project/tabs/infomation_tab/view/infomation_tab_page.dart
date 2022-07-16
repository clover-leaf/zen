import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/project/tabs/infomation_tab/infomation_tab.dart';
import 'package:intl/intl.dart';
import 'package:iot_api/iot_api.dart';

class InfomationTabPage extends StatelessWidget {
  const InfomationTabPage({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InfomationTabBloc(project: project),
      child: const InfomationTabView(),
    );
  }
}

class InfomationTabView extends StatelessWidget {
  const InfomationTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final project =
        context.select((InfomationTabBloc bloc) => bloc.state.project);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoBox(title: project.projectName, subtitle: 'Name'),
          InfoBox(title: project.city, subtitle: 'City'),
          InfoBox(title: project.district, subtitle: 'District'),
          InfoBox(title: project.ward, subtitle: 'Ward'),
          InfoBox(
            title: DateFormat('yMMMMd').format(project.createAt),
            subtitle: 'Create at',
          ),
        ],
      ),
    );
  }
}
