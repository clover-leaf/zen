part of 'gateway_bloc.dart';

class GatewayEvent extends Equatable {
  const GatewayEvent();

  @override
  List<Object> get props => [];
}

class BrokerSubscriptionRequested extends GatewayEvent {
  const BrokerSubscriptionRequested();
}

class MqttDeviceSubscriptionRequested extends GatewayEvent {
  const MqttDeviceSubscriptionRequested();
}

class TileConfigSubscriptionRequested extends GatewayEvent {
  const TileConfigSubscriptionRequested();
}

class GatewayClientInitialized extends GatewayEvent {
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

class MqttSubscribed extends GatewayEvent {
  const MqttSubscribed();

  @override
  List<Object> get props => [];
}

class ActionPublished extends GatewayEvent {
  const ActionPublished({
    required this.tileConfig,
    required this.payload,
  });

  final TileConfig tileConfig;
  final String payload;

  @override
  List<Object> get props => [tileConfig, payload];
}
