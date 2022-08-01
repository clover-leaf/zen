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
    required this.project,
    this.deviceView = const {},
    this.initTileConfig,
    required this.tileType,
    this.status = EditTileStatus.initializing,
    this.name,
    this.deviceID,
    required this.tileData,
  });

  // <<< IMMUTABLE >>>
  /// The showed [Project]
  final Project project;

  /// The map of [FieldId] of [Device] and it
  ///
  /// <Device.id, Device>
  final Map<FieldId, Device> deviceView;

  /// The [List] of [Device]
  late final List<Device> devices = deviceView.values.toList();

  /// The initial tile config
  final TileConfig? initTileConfig;

  /// The tile config's type
  final TileType tileType;
  // <<< IMMUTABLE >>>

  // <<< MUTABLE >>>
  /// The status of state
  final EditTileStatus status;

  /// The tile config's name
  final String? name;

  /// The tile config's device ID
  final FieldId? deviceID;

  /// The tile config's data
  final TileData tileData;
  // <<< MUTABLE >>>

  /// Whether every needed fields had filled or not
  bool isFilled() {
    if (initTileConfig != null) {
      final device = deviceView[deviceID ?? initTileConfig!.deviceID];
      return tileData.isFilled(device!);
    } else {
      final titleFilled = name != null && name != '';
      final deviceIdFilled = deviceID != null && deviceID != null;
      final device = deviceView[deviceID];
      if (device == null) {
        return false;
      }
      return titleFilled && deviceIdFilled && tileData.isFilled(device);
    }
  }

  /// Whether any field had edited or not
  bool get isEdited {
    if (initTileConfig != null) {
      return name != initTileConfig!.name ||
          deviceID != initTileConfig!.deviceID ||
          tileData != initTileConfig!.tileData;
    } else {
      final placeholadTileData = TileData.placeholder(tileType: tileType);
      final isTitleEdited = name != null && name != '';
      final isDeviceIdEdited = deviceID != null;
      return isTitleEdited ||
          isDeviceIdEdited ||
          tileData != placeholadTileData;
    }
  }

  EditTileState copyWith({
    Project? project,
    EditTileStatus? status,
    Map<FieldId, Device>? deviceView,
    TileConfig? initTileConfig,
    String? name,
    FieldId? deviceID,
    TileType? tileType,
    TileData? tileData,
  }) {
    return EditTileState(
      project: project ?? this.project,
      status: status ?? this.status,
      deviceView: deviceView ?? this.deviceView,
      initTileConfig: initTileConfig ?? this.initTileConfig,
      name: name ?? this.name,
      deviceID: deviceID ?? this.deviceID,
      tileType: tileType ?? this.tileType,
      tileData: tileData ?? this.tileData,
    );
  }

  @override
  List<Object?> get props {
    return [
      project,
      status,
      deviceView,
      name,
      deviceID,
      tileType,
      tileData,
    ];
  }
}
