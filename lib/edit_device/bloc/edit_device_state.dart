part of 'edit_device_bloc.dart';

enum EditDeviceStatus { initializing, initialized, saving, success, failure }

extension EditDeviceStatusX on EditDeviceStatus {
  bool get isInitializing => this == EditDeviceStatus.initializing;

  bool get isInitialized => this == EditDeviceStatus.initialized;

  bool get isSaving => this == EditDeviceStatus.saving;

  bool get isSuccess => this == EditDeviceStatus.success;

  bool get isFailure => this == EditDeviceStatus.failure;
}

@immutable
class EditDeviceState extends Equatable {
  const EditDeviceState({
    this.status = EditDeviceStatus.initializing,
    required this.projectID,
    this.initDevice,
    this.title,
    this.topic,
    this.jsonEnable = false,
    this.jsonVariables = const [],
  });

  // <<< IMMUTABLE >>>
  /// The initial device
  final Device? initDevice;

  /// The [Project] ID
  final FieldId? projectID;
  // <<< IMMUTABLE >>>

  // <<< MUTABLE >>>
  /// The status of state
  final EditDeviceStatus status;

  /// The device's title
  final String? title;

  /// The device's topic
  final String? topic;

  /// The device's json enable
  final bool jsonEnable;

  /// The device's json enable
  final List<JsonVariable> jsonVariables;
  // <<< MUTABLE >>>

  /// Whether every needed fields had filled or not
  bool isFilled() {
    final titleFilled = title != null && title != '';
    final topicFilled = topic != null && topic != '';
    final jsonVariablesFilled = !jsonVariables
        .map((jsonVariable) => jsonVariable.isFilled)
        .contains(false);
    return titleFilled && topicFilled && jsonVariablesFilled;
  }

  /// Whether any field had edited or not
  bool isEdited() {
    if (initDevice != null) {
      return title != initDevice!.title ||
          topic != initDevice!.topic ||
          jsonEnable != initDevice!.jsonEnable ||
          jsonVariables != initDevice!.jsonVariables;
    } else {
      return (title != null && title != '') &&
          (topic != null && topic != '') &&
          jsonVariables != <JsonVariable>[];
    }
  }

  EditDeviceState copyWith({
    Device? initDevice,
    FieldId? projectID,
    EditDeviceStatus? status,
    String? title,
    String? topic,
    bool? jsonEnable,
    List<JsonVariable>? jsonVariables,
  }) {
    return EditDeviceState(
      initDevice: initDevice ?? this.initDevice,
      projectID: projectID ?? this.projectID,
      status: status ?? this.status,
      title: title ?? this.title,
      topic: topic ?? this.topic,
      jsonEnable: jsonEnable ?? this.jsonEnable,
      jsonVariables: jsonVariables ?? this.jsonVariables,
    );
  }

  @override
  List<Object?> get props {
    return [
      initDevice,
      projectID,
      status,
      title,
      topic,
      jsonEnable,
      jsonVariables,
    ];
  }
}
