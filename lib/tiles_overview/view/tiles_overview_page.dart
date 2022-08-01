import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/edit_tile/view/edit_tile_page.dart';
import 'package:flutter_firestore/gen/assets.gen.dart';
import 'package:flutter_firestore/tiles_overview/tiles_overview.dart';
import 'package:iot_api/iot_api.dart';
import 'package:user_repository/user_repository.dart';

class TilesOverviewPage extends StatelessWidget {
  const TilesOverviewPage({super.key});

  static Page<void> page() =>
      const MaterialPage<void>(child: TilesOverviewPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TilesOverviewBloc(
        repository: context.read<UserRepository>(),
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
    final deviceStatusView = state.deviceStatusView;
    final projects = state.projects;
    final projectView = state.projectView;
    final projectID = state.projectID;

    final mediaWidth = MediaQuery.of(context).size.width;
    final tileWidgetWidth =
        (mediaWidth - Space.contentPaddingHorizontal.value * 2.5) / 2;

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
          if (value != null && !status.isInitializing) {
            if (projectID == null) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  MySnackBar.showSnackBar(
                    context: context,
                    content: 'There are no projects',
                    snackBarType: SnackBarType.error,
                  ),
                );
            } else {
              Navigator.of(context).push<void>(
                EditTilePage.route(
                  project: projectView[projectID]!,
                  tileType: value,
                  deviceView: deviceView,
                  initTileConfig: null,
                ),
              );
            }
          }
        }),
      ),
      bottomNavigationBar: MyBottomAppbar(
        prefixIcon: Assets.icons.justify,
        prefixOnTapped: () {
          if (!status.isInitializing) {
            showModalBottomSheet<FieldId>(
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
            });
          }
        },
        postfixIcon: Assets.icons.template,
        postfixOnTapped: () {
          if (!status.isInitializing) {
            showModalBottomSheet<FieldId>(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (_) => DeviceStatusSheet(
                project: projectView[projectID]!,
                deviceStatusView: deviceStatusView,
                paddingTop: MediaQuery.of(context).viewPadding.top,
                deviceView: deviceView,
              ),
            );
          }
        },
      ),
      body: BlocBuilder<TilesOverviewBloc, TilesOverviewState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (status.isInitializing) {
            return const Center(child: MyCircularProgress(size: 24));
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
                  const Expanded(
                    child: MyEmptyPage(
                      message: 'There are no projects.'
                          ' \nCreate a new ones to start!',
                    ),
                  )
                else
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const _Headline(),
                        if (showedTileConfigIDs.isEmpty)
                          const Expanded(
                            child: MyEmptyPage(
                              message: 'There are no tile configs.'
                                  ' \nCreate a new ones to start!',
                            ),
                          )
                        else
                          Expanded(
                            child: Wrap(
                              spacing: Space.contentPaddingHorizontal.value / 2,
                              runSpacing:
                                  Space.contentPaddingHorizontal.value / 2,
                              children: [
                                ...showedTileConfigIDs.map((tileConfigID) {
                                  final tileConfig =
                                      tileConfigView[tileConfigID]!;
                                  final tileType = tileConfig.tileType;
                                  final value = tileValueView[tileConfigID];
                                  return TileWidget(
                                    project: projectView[projectID]!,
                                    deviceView: deviceView,
                                    tileType: tileType,
                                    tileConfig: tileConfig,
                                    value: value,
                                    width: tileWidgetWidth,
                                  );
                                })
                              ],
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
        projectView[projectID]!.name,
        style: textTheme.headlineSmall,
      ),
    );
  }
}
