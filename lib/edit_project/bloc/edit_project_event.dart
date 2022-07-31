part of 'edit_project_bloc.dart';

class EditProjectEvent extends Equatable {
  const EditProjectEvent();

  @override
  List<Object> get props => [];
}

class EditProjectInitialized extends EditProjectEvent {
  const EditProjectInitialized();
}

class EditProjectStatusChanged extends EditProjectEvent {
  const EditProjectStatusChanged(this.status);

  final EditProjectStatus status;

  @override
  List<Object> get props => [status];
}

class EditProjectNameChanged extends EditProjectEvent {
  const EditProjectNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class EditProjectDescriptionChanged extends EditProjectEvent {
  const EditProjectDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class EditProjectSubmitted extends EditProjectEvent {
  const EditProjectSubmitted();
}
