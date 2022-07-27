part of 'project_detail_bloc.dart';

class ProjectDetailEvent extends Equatable {
  const ProjectDetailEvent();

  @override
  List<Object> get props => [];
}

class InitializeRequested extends ProjectDetailEvent {
  const InitializeRequested();
}

class ProjectSubscriptionRequested extends ProjectDetailEvent {
  const ProjectSubscriptionRequested();
}
