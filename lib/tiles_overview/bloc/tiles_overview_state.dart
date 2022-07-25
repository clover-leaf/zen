part of 'tiles_overview_bloc.dart';

enum TilesOverviewStatus { initial, loading, success, failure }

extension TilesOverviewStatusX on TilesOverviewStatus {
  bool get isInitial => this == TilesOverviewStatus.initial;

  bool get isLoading => this == TilesOverviewStatus.loading;

  bool get isSuccess => this == TilesOverviewStatus.success;

  bool get isFailure => this == TilesOverviewStatus.failure;
}

class TilesOverviewState extends Equatable {
  TilesOverviewState({
    this.status = TilesOverviewStatus.initial,
    this.mqttDeviceView = const {},
    this.brokerView = const {},
    this.tileConfigView = const {},
    this.gatewayClientView = const {},
    this.tileValueView = const {},
    this.subscribedTopics = const {},
  });

  /// The loading status of bloc
  final TilesOverviewStatus status;

  /// The map of [FieldId] of [Broker] and it
  ///
  /// <BrokerId, MqttDevice>
  final Map<FieldId, Broker> brokerView;

  /// the list of [Broker]
  late final List<Broker> brokers = brokerView.values.toList();

  /// The map of [FieldId] of [MqttDevice] and it
  ///
  /// <MqttDeviceId, MqttDevice>
  final Map<FieldId, MqttDevice> mqttDeviceView;

  /// the list of [MqttDevice]
  late final List<MqttDevice> mqttDevices = mqttDeviceView.values.toList();

  /// The map of [FieldId] of [Broker] and its [GatewayClient]
  ///
  /// <BrokerID, GatewayClient>
  final Map<FieldId, GatewayClient> gatewayClientView;

  /// The list of [GatewayClient]
  ///
  /// save to create stream of published messages
  late final List<GatewayClient> gatewayClients =
      gatewayClientView.values.toList();

  /// The map of [FieldId] of [TileConfig] and it
  ///
  /// <TileConfigID, TileConfig>
  final Map<FieldId, TileConfig> tileConfigView;

  /// The list of [TileConfig]
  ///
  /// save to display tile
  late final List<TileConfig> tileConfigs = tileConfigView.values.toList();

  /// The map of [FieldId] of [TileConfig] and its value
  ///
  /// <TileConfigID, value>
  final Map<FieldId, String?> tileValueView;

  /// The map of subscribed topic and its last message
  ///
  /// save to manage which topic is subscribed
  final Map<String, String> subscribedTopics;

  TilesOverviewState copyWith({
    TilesOverviewStatus? status,
    Map<FieldId, Broker>? brokerView,
    Map<FieldId, MqttDevice>? mqttDeviceView,
    Map<FieldId, TileConfig>? tileConfigView,
    Map<FieldId, GatewayClient>? gatewayClientView,
    Map<FieldId, String?>? tileValueView,
    Map<String, String>? subscribedTopics,
  }) =>
      TilesOverviewState(
        status: status ?? this.status,
        brokerView: brokerView ?? this.brokerView,
        mqttDeviceView: mqttDeviceView ?? this.mqttDeviceView,
        tileConfigView: tileConfigView ?? this.tileConfigView,
        gatewayClientView: gatewayClientView ?? this.gatewayClientView,
        subscribedTopics: subscribedTopics ?? this.subscribedTopics,
        tileValueView: tileValueView ?? this.tileValueView,
      );

  @override
  List<Object> get props => [
        status,
        brokerView,
        mqttDeviceView,
        tileConfigView,
        gatewayClientView,
        tileValueView,
        subscribedTopics,
      ];
}
