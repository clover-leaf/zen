part of 'infomation_tab_bloc.dart';


class InfomationTabState extends Equatable {
  const InfomationTabState({
    required this.device,
  });
  
  final Device device;

  InfomationTabState copyWith({
    Device? device,
  }) => InfomationTabState(
    device: device ?? this.device,
  );
  
  @override
  List<Object> get props => [device];
}
