part of 'edit_project_bloc.dart';

enum EditProjectStatus { initializing, initialized, saving, success, failure }

extension EditProjectStatusX on EditProjectStatus {
  bool get isInitializing => this == EditProjectStatus.initializing;

  bool get isInitialized => this == EditProjectStatus.initialized;

  bool get isSaving => this == EditProjectStatus.saving;

  bool get isSuccess => this == EditProjectStatus.success;

  bool get isFailure => this == EditProjectStatus.failure;
}

class EditProjectState extends Equatable {
  /// {macro EditTileState}
  EditProjectState({
    this.projectView = const {},
    this.initProject,
    this.status = EditProjectStatus.initializing,
    this.name,
    this.description,
  });

  // <<< IMMUTABLE >>>
  /// The map of [FieldId] of [Project] and it
  ///
  /// <Project.id, Project>
  final Map<FieldId, Project> projectView;

  /// The [List] of [Project]
  late final List<Project> projects = projectView.values.toList();

  /// The initial project
  final Project? initProject;

  // <<< IMMUTABLE >>>

  // <<< MUTABLE >>>
  /// The status of state
  final EditProjectStatus status;

  /// The project's name
  final String? name;

  /// The project's name
  late final String? key = name?.replaceAll(' ', '-');

  /// The project's name
  final String? description;
  // <<< MUTABLE >>>

  /// Whether every needed fields had filled or not
  bool isFilled() {
    return name != null;
  }

  /// Whether any field had edited or not
  bool get isEdited {
    if (initProject != null) {
      return name != initProject!.name &&
          description != initProject!.description;
    } else {
      return name != null &&
          name != '' &&
          description != null &&
          description != '';
    }
  }

  EditProjectState copyWith({
    Map<FieldId, Project>? projectView,
    Project? initProject,
    EditProjectStatus? status,
    String? name,
    String? description,
  }) =>
      EditProjectState(
        projectView: projectView ?? this.projectView,
        initProject: initProject ?? this.initProject,
        status: status ?? this.status,
        name: name ?? this.name,
        description: description ?? this.description,
      );

  @override
  List<Object?> get props =>
      [projectView, initProject, status, name, description];
}
