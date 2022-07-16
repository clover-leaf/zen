part of 'infomation_tab_bloc.dart';


class InfomationTabState extends Equatable {
  const InfomationTabState({
    required this.project,
  });
  
  final Project project;

  InfomationTabState copyWith({
    Project? project,
  }) => InfomationTabState(
    project: project ?? this.project,
  );
  
  @override
  List<Object> get props => [project];
}
