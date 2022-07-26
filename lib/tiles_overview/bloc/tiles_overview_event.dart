part of 'tiles_overview_bloc.dart';

class TilesOverviewEvent extends Equatable {
  const TilesOverviewEvent();

  @override
  List<Object> get props => [];
}

class Initialized extends TilesOverviewEvent {
  const Initialized();
}

class ProjectSubscriptionRequested extends TilesOverviewEvent {
  const ProjectSubscriptionRequested();
}

class DeviceSubscriptionRequested extends TilesOverviewEvent {
  const DeviceSubscriptionRequested();
}

class TileConfigSubscriptionRequested extends TilesOverviewEvent {
  const TileConfigSubscriptionRequested();
}

class ConnectionStatusSubscriptionRequested extends TilesOverviewEvent {
  const ConnectionStatusSubscriptionRequested();
}

class GatewayClientInitialized extends TilesOverviewEvent {
  const GatewayClientInitialized({
    required this.brokerView,
    required this.mqttDeviceView,
    required this.tileConfigView,
  });

  final Map<FieldId, Broker> brokerView;
  final Map<FieldId, Device> mqttDeviceView;
  final Map<FieldId, TileConfig> tileConfigView;

  @override
  List<Object> get props => [brokerView, mqttDeviceView, tileConfigView];
}

class BrokerListened extends TilesOverviewEvent {
  const BrokerListened();
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
