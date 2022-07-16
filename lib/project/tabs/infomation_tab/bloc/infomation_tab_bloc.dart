import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iot_api/iot_api.dart';

part 'infomation_tab_event.dart';
part 'infomation_tab_state.dart';

class InfomationTabBloc extends Bloc<InfomationTabEvent, InfomationTabState> {
  InfomationTabBloc({required Project project})
      : super(InfomationTabState(project: project));
}
