import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iot_api/iot_api.dart';
import 'package:user_repository/user_repository.dart';

part 'projects_overview_event.dart';
part 'projects_overview_state.dart';

class ProjectsOverviewBloc
    extends Bloc<ProjectsOverviewEvent, ProjectsOverviewState> {
  ProjectsOverviewBloc({
    required this.repository,
  }) : super(
          ProjectsOverviewState(),
        ) {
    on<InitializeRequested>(_onInitializeRequested);
    on<ProjectSubscriptionRequested>(_onProjectSubscriptionRequested);
  }

  /// The IoT repository instance
  final UserRepository repository;

  /// Initializes
  void _onInitializeRequested(
    InitializeRequested event,
    Emitter<ProjectsOverviewState> emit,
  ) {
    add(const ProjectSubscriptionRequested());
    emit(
      state.copyWith(
        status: ProjectsOverviewStatus.initialized,
      ),
    );
  }

  /// Subcribes [Stream] of [List] of [Project]
  Future<void> _onProjectSubscriptionRequested(
    ProjectSubscriptionRequested event,
    Emitter<ProjectsOverviewState> emit,
  ) async {
    await emit.forEach<List<Project>>(
      repository.getProjects(),
      onData: (projects) {
        final projectView = {for (var project in projects) project.id: project};
        return state.copyWith(projectView: projectView);
      },
    );
  }
}
