part of 'edit_device_bloc.dart';

class EditDeviceEvent extends Equatable {
  const EditDeviceEvent();

  @override
  List<Object> get props => [];
}

class EditDeviceInitialized extends EditDeviceEvent {
  const EditDeviceInitialized();
}

class EditDeviceStatusChanged extends EditDeviceEvent {
  const EditDeviceStatusChanged(this.status);

  final EditDeviceStatus status;

  @override
  List<Object> get props => [status];
}

class EditDeviceNameChanged extends EditDeviceEvent {
  const EditDeviceNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class EditDeviceJsonEnableChanged extends EditDeviceEvent {
  const EditDeviceJsonEnableChanged({required this.jsonEnable});

  final bool jsonEnable;

  @override
  List<Object> get props => [jsonEnable];
}

class EditDeviceJsonVariableSaved extends EditDeviceEvent {
  const EditDeviceJsonVariableSaved({required this.jsonVariable});

  final JsonVariable jsonVariable;

  @override
  List<Object> get props => [jsonVariable];
}

class EditDeviceJsonVariableDeleted extends EditDeviceEvent {
  const EditDeviceJsonVariableDeleted({required this.jsonVariable});

  final JsonVariable jsonVariable;

  @override
  List<Object> get props => [jsonVariable];
}

class EditDeviceSubmitted extends EditDeviceEvent {
  const EditDeviceSubmitted();
}
