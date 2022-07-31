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
    this.projectID,
    this.deviceView = const {},
    this.initTileConfig,
    required this.tileType,
    this.status = EditTileStatus.initializing,
    this.title,
    this.deviceID,
    required this.tileData,
  });

  // <<< IMMUTABLE >>>
  /// The ID of showed [Project]
  final FieldId? projectID;

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

  /// The tile config's title
  final String? title;

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
      final titleFilled = title != null && title != '';
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
      return title != initTileConfig!.title ||
          deviceID != initTileConfig!.deviceID ||
          tileData != initTileConfig!.tileData;
    } else {
      final placeholadTileData = TileData.placeholder(tileType: tileType);
      final isTitleEdited = title != null && title != '';
      final isDeviceIdEdited = deviceID != null;
      return isTitleEdited ||
          isDeviceIdEdited ||
          tileData != placeholadTileData;
    }
  }

  EditTileState copyWith({
    FieldId? projectID,
    EditTileStatus? status,
    Map<FieldId, Device>? deviceView,
    TileConfig? initTileConfig,
    String? title,
    FieldId? deviceID,
    TileType? tileType,
    TileData? tileData,
  }) {
    return EditTileState(
      projectID: projectID ?? this.projectID,
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
      projectID,
      status,
      deviceView,
      title,
      deviceID,
      tileType,
      tileData,
    ];
  }
}
