part of 'edit_tile_bloc.dart';

enum EditTileStatus { initial, saving, success, failure }

extension EditTileStatusX on EditTileStatus {
  bool get isSaving => this == EditTileStatus.saving;

  bool get isSuccess => this == EditTileStatus.success;

  bool get isFailure => this == EditTileStatus.failure;
}

class EditTileState extends Equatable {
  /// {macro EditTileState}
  EditTileState({
    this.status = EditTileStatus.initial,
    this.brokerView = const {},
    this.deviceView = const {},
    this.initTileConfig,
    this.title = '',
    this.deviceID = '',
    required this.tileType,
    required this.tileData,
  });

  /// processes status
  final EditTileStatus status;

  /// <BrokerID, Broker>
  final Map<FieldId, Broker> brokerView;
  late final List<Broker> brokers = brokerView.values.toList();

  /// <mqttDeviceId, Device>
  final Map<FieldId, Device> deviceView;
  late final List<Device> mqttDevices = deviceView.values.toList();

  /// initial tile config
  final TileConfig? initTileConfig;

  /// tile config's title
  final String title;

  /// tile config's device ID
  final String deviceID;

  /// tile config's type
  final TileType tileType;

  /// tile config's data
  final TileData tileData;

  /// return true if every needed fields had filled
  bool isFilled() {
    final device = deviceView[deviceID];
    return title != '' && deviceID != '' && tileData.isFill(device!);
  } 

  /// return true if any field had edited
  bool get isEditted {
    if (initTileConfig != null) {
      return title != initTileConfig!.title ||
          deviceID != initTileConfig!.deviceID ||
          tileData != initTileConfig!.tileData;
    } else {
      final placeholadTileConfig = TileConfig.placeholder(tileType: tileType);
      return title != placeholadTileConfig.title ||
          deviceID != placeholadTileConfig.deviceID ||
          tileData != placeholadTileConfig.tileData;
    }
  }

  EditTileState copyWith({
    EditTileStatus? status,
    Map<FieldId, Broker>? brokerView,
    Map<FieldId, Device>? deviceView,
    TileConfig? initTileConfig,
    String? title,
    String? deviceID,
    TileType? tileType,
    TileData? tileData,
  }) {
    return EditTileState(
      status: status ?? this.status,
      brokerView: brokerView ?? this.brokerView,
      deviceView: deviceView ?? this.deviceView,
      initTileConfig: initTileConfig ?? this.initTileConfig,
      title: title ?? this.title,
      deviceID: deviceID ?? this.deviceID,
      tileType: tileType ?? this.tileType,
      tileData: tileData ?? this.tileData,
    );
  }

  @override
  List<Object> get props {
    return [
      status,
      brokerView,
      deviceView,
      title,
      deviceID,
      tileType,
      tileData,
    ];
  }
}
