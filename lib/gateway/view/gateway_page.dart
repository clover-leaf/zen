import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/edit_tile/view/edit_tile_page.dart';
import 'package:flutter_firestore/gateway/gateway.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

class GatewayPage extends StatelessWidget {
  const GatewayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GatewayBloc(
        repository: context.read<IotRepository>(),
      )
        ..add(const BrokerSubscriptionRequested())
        ..add(const MqttDeviceSubscriptionRequested())
        ..add(const TileConfigSubscriptionRequested()),
      child: const GatewayView(),
    );
  }
}

class GatewayView extends StatelessWidget {
  const GatewayView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GatewayBloc>().state;
    final tileConfigs = state.tileConfigs;
    final tileConfigView = state.tileConfigView;
    final brokerView = state.brokerView;
    final mqttDeviceView = state.mqttDeviceView;
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
                brokerView: brokerView,
                mqttDeviceView: mqttDeviceView,
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
      body: BlocBuilder<GatewayBloc, GatewayState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (state.status.isLoading) {
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
                            brokerView: brokerView,
                            mqttDeviceView: mqttDeviceView,
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
