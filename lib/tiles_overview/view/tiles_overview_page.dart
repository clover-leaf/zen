import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/edit_tile/view/edit_tile_page.dart';
import 'package:flutter_firestore/tiles_overview/tiles_overview.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

class TilesOverviewPage extends StatelessWidget {
  const TilesOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TilesOverviewBloc(
        repository: context.read<IotRepository>(),
      )..add(const InitializeRequested()),
      child: const TilesOverviewView(),
    );
  }
}

class TilesOverviewView extends StatelessWidget {
  const TilesOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TilesOverviewBloc>().state;
    final textTheme = Theme.of(context).textTheme;
    final status = state.status;
    final showedTileConfigIDs = state.showedTileConfigIDs;
    final tileValueView = state.tileValueView;
    final tileConfigView = state.tileConfigView;
    final deviceView = state.deviceView;
    final projects = state.projects;
    final projectView = state.projectView;
    final projectID = state.projectID;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MyFloatingButton(
        onPressed: () => showModalBottomSheet<TileType>(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (_) => const NewTileSheet(),
        ).then((value) {
          if (value != null) {
            Navigator.of(context).push<void>(
              EditTilePage.route(
                tileType: value,
                deviceView: deviceView,
                initTileConfig: null,
              ),
            );
          }
        }),
      ),
      bottomNavigationBar: MyBottomAppbar(
        prefixIcon: MyIcon.justify.getPath(),
        prefixOnTapped: () => status.isInitializing
            ? null
            : showModalBottomSheet<FieldId>(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (_) => MenuSheet(
                  projects: projects,
                  projectView: projectView,
                  deviceView: deviceView,
                ),
              ).then((projectID) {
                if (projectID != null) {
                  context
                      .read<TilesOverviewBloc>()
                      .add(ProjectChangeRequested(projectID));
                }
              }),
        postfixIcon: MyIcon.template.getPath(),
        postfixOnTapped: () {},
      ),
      body: BlocBuilder<TilesOverviewBloc, TilesOverviewState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (status.isInitializing) {
            return const MyCircularProgress(size: 24);
          }
          return Padding(
            padding: EdgeInsets.fromLTRB(
              Space.contentPaddingHorizontal.value,
              Space.contentPaddingTop.value +
                  MediaQuery.of(context).viewPadding.top,
              Space.contentPaddingHorizontal.value,
              0,
            ),
            child: Column(
              children: [
                if (!status.isConnected)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 24,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      color: Color(0xfff9e5e6),
                    ),
                    child: Row(
                      children: [
                        const MyCircularProgress(
                          size: 24,
                          padding: EdgeInsets.only(right: 24),
                        ),
                        Text(
                          'Connecting with broker',
                          style: textTheme.titleMedium,
                        )
                      ],
                    ),
                  ),
                if (projectID == null)
                  Center(
                    child: Text(
                      'There is no project',
                      style: textTheme.displaySmall,
                    ),
                  )
                else
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const _Headline(),
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 24),
                            itemCount: showedTileConfigIDs.length,
                            itemBuilder: (context, index) {
                              final tileConfigID = showedTileConfigIDs[index];
                              final tileConfig = tileConfigView[tileConfigID]!;
                              final tileType = tileConfig.tileType;
                              final value = tileValueView[tileConfigID];
                              return TileWidget(
                                deviceView: deviceView,
                                tileType: tileType,
                                tileConfig: tileConfig,
                                value: value,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Headline extends StatelessWidget {
  const _Headline();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final state = context.watch<TilesOverviewBloc>().state;
    final projectView = state.projectView;
    final projectID = state.projectID;

    return Padding(
      padding: EdgeInsets.only(bottom: Space.contentItemGap.value),
      child: Text(
        projectView[projectID]!.title,
        style: textTheme.headlineSmall,
      ),
    );
  }
}
