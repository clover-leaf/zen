part of 'tiles_overview_bloc.dart';

class TilesOverviewEvent extends Equatable {
  const TilesOverviewEvent();

  @override
  List<Object> get props => [];
}

class BrokerSubscriptionRequested extends TilesOverviewEvent {
  const BrokerSubscriptionRequested();
}

class MqttDeviceSubscriptionRequested extends TilesOverviewEvent {
  const MqttDeviceSubscriptionRequested();
}

class TileConfigSubscriptionRequested extends TilesOverviewEvent {
  const TileConfigSubscriptionRequested();
}

class GatewayClientInitialized extends TilesOverviewEvent {
  const GatewayClientInitialized({
    required this.brokerView,
    required this.mqttDeviceView,
    required this.tileConfigView,
  });

  final Map<FieldId, Broker> brokerView;
  final Map<FieldId, MqttDevice> mqttDeviceView;
  final Map<FieldId, TileConfig> tileConfigView;

  @override
  List<Object> get props => [brokerView, mqttDeviceView, tileConfigView];
}

class MqttSubscribed extends TilesOverviewEvent {
  const MqttSubscribed();

  @override
  List<Object> get props => [];
}

class ActionPublished extends TilesOverviewEvent {
  const ActionPublished({
    required this.tileConfig,
    required this.payload,
  });

  final TileConfig tileConfig;
  final String payload;

  @override
  List<Object> get props => [tileConfig, payload];
}
