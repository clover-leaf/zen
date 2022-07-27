part of 'tiles_overview_bloc.dart';

enum TilesOverviewStatus {
  initializing,
  initialized,
  connected,
}

extension TilesOverviewStatusX on TilesOverviewStatus {
  bool get isInitializing => this == TilesOverviewStatus.initializing;

  bool get isInitialized => this == TilesOverviewStatus.initialized;

  bool get isConnected => this == TilesOverviewStatus.connected;
}

class TilesOverviewState extends Equatable {
  TilesOverviewState({
    this.status = TilesOverviewStatus.initializing,
    this.gatewayClient,
    this.projectID,
    this.projectView = const {},
    this.deviceView = const {},
    this.tileConfigView = const {},
    this.tileValueView = const {},
    this.subscribedTopics = const {},
  });

  /// The status of state
  final TilesOverviewStatus status;

  /// The only [GatewayClient] of page
  ///
  /// Creates only once after bloc is initialized
  /// Immutable
  final GatewayClient? gatewayClient;

  /// The map of [FieldId] of [Project] and it
  ///
  /// <Project.id, Project>
  final Map<FieldId, Project> projectView;

  /// The list of [Project]
  late final List<Project> projects = projectView.values.toList();

  /// The [FieldId] of [Project]
  ///
  /// Indicates which [Project] is showing
  final FieldId? projectID;

  /// The map of [FieldId] of [Device] and it
  ///
  /// <Device.id, Device>
  final Map<FieldId, Device> deviceView;

  /// The list of [Device]
  late final List<Device> devices = deviceView.values.toList();

  /// The map of all [TileConfig] across all project
  ///
  /// <TileConfigID, TileConfig>
  final Map<FieldId, TileConfig> tileConfigView;

  /// The list of [TileConfig]
  late final List<TileConfig> tileConfigs = tileConfigView.values.toList();

  /// The map of [TileConfig] with its latest value
  ///
  /// There is a bijection from tileConfigView to TileValueView
  /// When tileConfigView changes, it also changes
  /// Beside, it only change value of pair when coming payload listened,
  /// but never change its size in this case
  final Map<FieldId, String?> tileValueView;

  /// The map of subscribed topic and its last message
  ///
  /// There is a bijection from deviceView to subscribedTopic,
  /// When deviceView changes, it also changes
  /// Note: message mean raw payload that not
  /// extracted JSON yet (if JSON is enabled)
  final Map<String, String?> subscribedTopics;

  /// Gets the [List] of [FieldId] of [TileConfig] 
  /// that belongs to projectID.
  /// 
  /// This updated when:
  /// 1. ProjectID changes (major)
  /// 2. TileConfigs changes (major)
  /// 3. DeviceView changes (minor)
  List<FieldId> get showedTileConfigIDs {
    // The map of each device.id with its project.id
    final deviceToProjectView = {
      for (final device in devices) device.id: device.projectID
    };
    final showedTileConfigIDs = <FieldId>[];
    // print(projectID);
    for (final tileConfig in tileConfigs) {
      if (deviceToProjectView[tileConfig.deviceID] == projectID) {
        showedTileConfigIDs.add(tileConfig.id);
      }
    }
    return showedTileConfigIDs;
  }

  /// Returns a copy of [TilesOverviewState] with given parameters
  TilesOverviewState copyWith({
    TilesOverviewStatus? status,
    GatewayClient? gatewayClient,
    FieldId? projectID,
    Map<FieldId, Project>? projectView,
    Map<FieldId, Device>? deviceView,
    Map<FieldId, TileConfig>? tileConfigView,
    Map<FieldId, String?>? tileValueView,
    Map<String, String?>? subscribedTopics,
  }) =>
      TilesOverviewState(
        status: status ?? this.status,
        gatewayClient: gatewayClient ?? this.gatewayClient,
        projectID: projectID ?? this.projectID,
        projectView: projectView ?? this.projectView,
        deviceView: deviceView ?? this.deviceView,
        tileConfigView: tileConfigView ?? this.tileConfigView,
        tileValueView: tileValueView ?? this.tileValueView,
        subscribedTopics: subscribedTopics ?? this.subscribedTopics,
      );

  @override
  List<Object?> get props => [
        status,
        gatewayClient,
        projectID,
        projectView,
        deviceView,
        tileConfigView,
        tileValueView,
        subscribedTopics,
      ];
}
