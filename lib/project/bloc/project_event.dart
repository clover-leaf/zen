part of 'project_bloc.dart';

class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object> get props => [];
}

class TabChanged extends ProjectEvent {
  const TabChanged(this.tab);

  final ProjectTab tab;

  @override
  List<Object> get props => [tab];
}
