import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

part 'project_detail_event.dart';
part 'project_detail_state.dart';

class ProjectDetailBloc extends Bloc<ProjectDetailEvent, ProjectDetailState> {
  ProjectDetailBloc({
    required this.repository,
    required FieldId projectID,
  }) : super(
          ProjectDetailState(
            projectID: projectID,
          ),
        ) {
    on<InitializeRequested>(_onInitializeRequested);
    on<ProjectSubscriptionRequested>(_onProjectSubscriptionRequested);
  }

  /// The IoT repository instance
  final IotRepository repository;

  /// Initializes
  void _onInitializeRequested(
    InitializeRequested event,
    Emitter<ProjectDetailState> emit,
  ) {
    add(const ProjectSubscriptionRequested());
    emit(state.copyWith(status: ProjectDetailStatus.initialized));
  }

  /// Subcribes [Stream] of [List] of [Project]
  Future<void> _onProjectSubscriptionRequested(
    ProjectSubscriptionRequested event,
    Emitter<ProjectDetailState> emit,
  ) async {
    await emit.forEach<List<Project>>(
      repository.getProjects(),
      onData: (projects) {
        final projectView = {for (var project in projects) project.id: project};
        if (!projectView.keys.contains(state.projectID)) {
          emit(state.copyWith(status: ProjectDetailStatus.error));
        }
        return state.copyWith(projectView: projectView);
      },
    );
  }
}
