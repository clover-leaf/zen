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
  const EditDeviceState({
    this.status = EditDeviceStatus.initializing,
    required this.project,
    this.initDevice,
    this.name,
    this.key,
    bool? jsonEnable,
    this.jsonVariables = const [],
  }) : jsonEnable = jsonEnable ?? false;

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
  final String? key;

  /// The device's json enable
  final bool jsonEnable;

  /// The device's json enable
  final List<JsonVariable> jsonVariables;
  // <<< MUTABLE >>>

  /// Whether every needed fields had filled or not
  bool isFilled() {
    final nameFilled = name != null && name != '';
    final keyFilled = key != null && key != '';
    if (jsonEnable) {
      final jsonVariablesFilled = !jsonVariables
          .map((jsonVariable) => jsonVariable.isFilled)
          .contains(false);
      return nameFilled &&
          keyFilled &&
          jsonVariables.isNotEmpty &&
          jsonVariablesFilled;
    } else {
      return nameFilled && keyFilled;
    }
  }

  /// Whether any field had edited or not
  bool get isEdited =>
      (initDevice != null &&
          (name != initDevice!.name ||
              key != initDevice!.key ||
              jsonEnable != initDevice!.jsonEnable ||
              jsonVariables != initDevice!.jsonVariables)) ||
      (initDevice == null &&
          (name != null ||
              name != '' ||
              key != null ||
              key != '' ||
              jsonEnable == true ||
              jsonVariables.isNotEmpty));

  EditDeviceState copyWith({
    Device? initDevice,
    Project? project,
    EditDeviceStatus? status,
    String? name,
    String? key,
    bool? jsonEnable,
    List<JsonVariable>? jsonVariables,
  }) {
    return EditDeviceState(
      initDevice: initDevice ?? this.initDevice,
      project: project ?? this.project,
      status: status ?? this.status,
      name: name ?? this.name,
      key: key ?? this.key,
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
      key,
      jsonEnable,
      jsonVariables,
    ];
  }
}
