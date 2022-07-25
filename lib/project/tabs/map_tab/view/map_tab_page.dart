import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/project/tabs/map_tab/map_tab.dart';
import 'package:iot_api/iot_api.dart';

class MapTabPage extends StatelessWidget {
  const MapTabPage({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapTabBloc(project: project),
      child: const MapTabView(),
    );
  }
}

class MapTabView extends StatelessWidget {
  const MapTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final project = context.select((MapTabBloc bloc) => bloc.state.project);
    return Column(
      children: [
        MapBox(
          latitude: project.latitude,
          longitude: project.longitude,
        ),
      ],
    );
  }
}
