part of 'edit_device_bloc.dart';

enum EditDeviceStatus { initializing, initialized, saving, success, failure }

extension EditDeviceStatusX on EditDeviceStatus {
  bool get isInitializing => this == EditDeviceStatus.initializing;

  bool get isInitialized => this == EditDeviceStatus.initialized;

  bool get isSaving => this == EditDeviceStatus.saving;

  bool get isSuccess => this == EditDeviceStatus.success;

  bool get isFailure => this == EditDeviceStatus.failure;
}

class EditDeviceState extends Equatable {
  EditDeviceState({
    this.status = EditDeviceStatus.initializing,
    required this.project,
    this.initDevice,
    this.name,
    this.jsonEnable = false,
    this.jsonVariables = const [],
  });

  // <<< IMMUTABLE >>>
  /// The initial device
  final Device? initDevice;

  /// The [Project]
  final Project project;
  // <<< IMMUTABLE >>>

  // <<< MUTABLE >>>
  /// The status of state
  final EditDeviceStatus status;

  /// The device's name
  final String? name;

  /// The device's key
  late final String? key = initDevice?.key ?? name?.replaceAll(' ', '-');

  /// The device's json enable
  final bool jsonEnable;

  /// The device's json enable
  final List<JsonVariable> jsonVariables;
  // <<< MUTABLE >>>

  /// Whether key name is legal
  bool isLegal() {
    return key != null && !key!.endsWith('<<status>>');
  }

  /// Whether every needed fields had filled or not
  bool isFilled() {
    final nameFilled = name != null && name != '';
    final keyFilled = key != null && key != '';
    final jsonVariablesFilled = !jsonVariables
        .map((jsonVariable) => jsonVariable.isFilled)
        .contains(false);
    return nameFilled && keyFilled && jsonVariablesFilled;
  }

  /// Whether any field had edited or not
  bool isEdited() {
    if (initDevice != null) {
      return name != initDevice!.name ||
          key != initDevice!.key ||
          jsonEnable != initDevice!.jsonEnable ||
          jsonVariables != initDevice!.jsonVariables;
    } else {
      return (name != null && name != '') &&
          (key != null && key != '') &&
          jsonVariables != <JsonVariable>[];
    }
  }

  EditDeviceState copyWith({
    Device? initDevice,
    Project? project,
    EditDeviceStatus? status,
    String? name,
    bool? jsonEnable,
    List<JsonVariable>? jsonVariables,
  }) {
    return EditDeviceState(
      initDevice: initDevice ?? this.initDevice,
      project: project ?? this.project,
      status: status ?? this.status,
      name: name ?? this.name,
      jsonEnable: jsonEnable ?? this.jsonEnable,
      jsonVariables: jsonVariables ?? this.jsonVariables,
    );
  }

  @override
  List<Object?> get props {
    return [
      initDevice,
      project,
      status,
      name,
      jsonEnable,
      jsonVariables,
    ];
  }
}
