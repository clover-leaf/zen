import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iot_api/iot_api.dart';
import 'package:user_repository/user_repository.dart';

part 'edit_project_event.dart';
part 'edit_project_state.dart';

class EditProjectBloc extends Bloc<EditProjectEvent, EditProjectState> {
  EditProjectBloc({
    required this.repository,
    required Project? initProject,
    required Map<FieldId, Project> projectView,
  }) : super(
          EditProjectState(
            projectView: projectView,
            initProject: initProject,
          ),
        ) {
    on<EditProjectInitialized>(_onInitialized);
    on<EditProjectStatusChanged>(_onStatusChanged);
    on<EditProjectNameChanged>(_onNameChanged);
    on<EditProjectDescriptionChanged>(_onDescriptionChanged);
    on<EditProjectSubmitted>(_onEditProjectSummited);
  }
  final UserRepository repository;

  void _onInitialized(
    EditProjectInitialized event,
    Emitter<EditProjectState> emit,
  ) {
    if (state.initProject != null) {
      emit(
        state.copyWith(
          status: EditProjectStatus.initialized,
          name: state.initProject!.name,
        ),
      );
    } else {
      emit(state.copyWith(status: EditProjectStatus.initialized));
    }
  }

  void _onStatusChanged(
    EditProjectStatusChanged event,
    Emitter<EditProjectState> emit,
  ) {
    emit(state.copyWith(status: event.status));
  }

  void _onNameChanged(
    EditProjectNameChanged event,
    Emitter<EditProjectState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  void _onDescriptionChanged(
    EditProjectDescriptionChanged event,
    Emitter<EditProjectState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _onEditProjectSummited(
    EditProjectSubmitted event,
    Emitter<EditProjectState> emit,
  ) async {
    emit(state.copyWith(status: EditProjectStatus.saving));
    late Project project;
    if (state.initProject != null) {
      project = Project(
        id: state.initProject!.id,
        name: state.name ?? state.initProject!.name,
        key: state.key ?? state.initProject!.key,
        description: state.description ?? state.initProject!.description,
      );
      try {
        await repository.updateProject(project, state.initProject!.key);
        emit(state.copyWith(status: EditProjectStatus.success));
      } catch (e) {
        emit(state.copyWith(status: EditProjectStatus.failure));
      }
    } else {
      project = Project(
        name: state.name!,
        key: state.key!,
        description: state.description,
      );
      try {
        await repository.saveProject(project);
        emit(state.copyWith(status: EditProjectStatus.success));
      } catch (e) {
        emit(state.copyWith(status: EditProjectStatus.failure));
      }
    }
  }
}
