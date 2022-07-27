part of 'projects_overview_bloc.dart';

class ProjectsOverviewEvent extends Equatable {
  const ProjectsOverviewEvent();

  @override
  List<Object> get props => [];
}

class InitializeRequested extends ProjectsOverviewEvent {
  const InitializeRequested();
}

class ProjectSubscriptionRequested extends ProjectsOverviewEvent {
  const ProjectSubscriptionRequested();
}
