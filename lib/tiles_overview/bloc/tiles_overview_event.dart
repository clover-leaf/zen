part of 'tiles_overview_bloc.dart';

class TilesOverviewEvent extends Equatable {
  const TilesOverviewEvent();

  @override
  List<Object> get props => [];
}

class InitializeRequested extends TilesOverviewEvent {
  const InitializeRequested();
}

class ClientConnectionStatusSubscriptionRequested extends TilesOverviewEvent {
  const ClientConnectionStatusSubscriptionRequested();
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

class BrokerConnectRequested extends TilesOverviewEvent {
  const BrokerConnectRequested();
}

class ProjectChangeRequested extends TilesOverviewEvent {
  const ProjectChangeRequested(this.projectID);

  final FieldId projectID;

  @override
  List<Object> get props => [projectID];
}

class BrokerListened extends TilesOverviewEvent {
  const BrokerListened();
}

class TileConfigDeleteRequested extends TilesOverviewEvent {
  const TileConfigDeleteRequested(this.tileConfig);

  final TileConfig tileConfig;

  @override
  List<Object> get props => [tileConfig];
}

class MessagePublishRequested extends TilesOverviewEvent {
  const MessagePublishRequested({
    required this.payload,
    required this.deviceID,
  });

  final String payload;
  final FieldId deviceID;

  @override
  List<Object> get props => [payload, deviceID];
}
