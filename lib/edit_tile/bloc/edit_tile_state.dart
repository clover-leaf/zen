part of 'edit_tile_bloc.dart';

enum EditTileStatus { initializing, initialized, saving, success, failure }

extension EditTileStatusX on EditTileStatus {
  bool get isInitializing => this == EditTileStatus.initializing;

  bool get isInitialized => this == EditTileStatus.initialized;

  bool get isSaving => this == EditTileStatus.saving;

  bool get isSuccess => this == EditTileStatus.success;

  bool get isFailure => this == EditTileStatus.failure;
}

class EditTileState extends Equatable {
  /// {macro EditTileState}
  EditTileState({
    this.deviceView = const {},
    this.initTileConfig,
    required this.tileType,
    this.status = EditTileStatus.initializing,
    this.title,
    this.deviceID,
    required this.tileData,
  });

  // <<< IMMUTABLE >>>
  /// The map of [FieldId] of [Device] and it
  ///
  /// <Device.id, Device>
  final Map<FieldId, Device> deviceView;

  /// The [List] of [Device]
  late final List<Device> mqttDevices = deviceView.values.toList();

  /// The initial tile config
  final TileConfig? initTileConfig;

  /// The tile config's type
  final TileType tileType;
  // <<< IMMUTABLE >>>

  // <<< MUTABLE >>>
  /// The status of state
  final EditTileStatus status;

  /// The tile config's title
  final String? title;

  /// The tile config's device ID
  final String? deviceID;

  /// The tile config's data
  final TileData tileData;
  // <<< MUTABLE >>>

  /// Whether every needed fields had filled or not
  bool isFilled() {
    if (initTileConfig != null) {
      final device = deviceView[deviceID ?? initTileConfig!.deviceID];
      return tileData.isFilled(device!);
    } else {
      final titleFilled = title != null && title != '';
      final deviceIdFilled = deviceID != null && deviceID != '';
      final device = deviceView[deviceID];
      if (device == null) {
        return false;
      }
      return titleFilled && deviceIdFilled && tileData.isFilled(device); 
    }
  }

  /// Whether any field had edited or not
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
    Map<FieldId, Device>? deviceView,
    TileConfig? initTileConfig,
    String? title,
    String? deviceID,
    TileType? tileType,
    TileData? tileData,
  }) {
    return EditTileState(
      status: status ?? this.status,
      deviceView: deviceView ?? this.deviceView,
      initTileConfig: initTileConfig ?? this.initTileConfig,
      title: title ?? this.title,
      deviceID: deviceID ?? this.deviceID,
      tileType: tileType ?? this.tileType,
      tileData: tileData ?? this.tileData,
    );
  }

  @override
  List<Object?> get props {
    return [
      status,
      deviceView,
      title,
      deviceID,
      tileType,
      tileData,
    ];
  }
}
