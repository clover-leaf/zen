import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/edit_tile/view/edit_tile_page.dart';
import 'package:flutter_firestore/tiles_overview/tiles_overview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

class TilesOverviewPage extends StatelessWidget {
  const TilesOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TilesOverviewBloc(
        repository: context.read<IotRepository>(),
      )
        ..add(const Initialized()),
      child: const TilesOverviewView(),
    );
  }
}

class TilesOverviewView extends StatelessWidget {
  const TilesOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TilesOverviewBloc>().state;
    final tileConfigs = state.tileConfigs;
    final tileConfigView = state.tileConfigView;
    final deviceView = state.deviceView;
    final tileValueView = state.tileValueView;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
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
        backgroundColor: Theme.of(context).primaryColor,
        child: SvgPicture.asset(
          MyIcon.add.getPath(),
          color: const Color(0xffffffff),
        ),
      ),
      bottomNavigationBar: MyBottomAppbar(
        prefixIcon: MyIcon.justify.getPath(),
        prefixOnTapped: () {},
        postfixIcon: MyIcon.template.getPath(),
        postfixOnTapped: () {},
      ),
      body: BlocBuilder<TilesOverviewBloc, TilesOverviewState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (state.status.isConnecting) {
            return const CircularProgressIndicator();
          } else if (state.status.isFailure) {
            return const Center(child: Text('failure'));
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _Headline(),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    separatorBuilder: (_, __) => const SizedBox(height: 24),
                    itemCount: tileConfigView.length,
                    itemBuilder: (context, index) {
                      final tileConfig = tileConfigs[index];
                      final tileType = tileConfig.tileType;
                      final value = tileValueView[tileConfig.id];
                      switch (tileType) {
                        case TileType.text:
                          return TextTileWidget(
                            tileConfig: tileConfig,
                            value: value,
                          );
                        case TileType.toggle:
                          return ToggleTileWidget(
                            tileConfig: tileConfig,
                            value: value,
                            deviceView: deviceView,
                          );
                      }
                    },
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

    return Padding(
      padding: EdgeInsets.fromLTRB(
        Space.contentPaddingHorizontal.value,
        0,
        Space.contentPaddingHorizontal.value,
        16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My house',
            style: textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
