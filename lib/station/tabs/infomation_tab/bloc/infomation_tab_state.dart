part of 'infomation_tab_bloc.dart';


class InfomationTabState extends Equatable {
  const InfomationTabState({
    required this.station,
  });
  
  final Station station;

  InfomationTabState copyWith({
    Station? station,
  }) => InfomationTabState(
    station: station ?? this.station,
  );
  
  @override
  List<Object> get props => [station];
}
