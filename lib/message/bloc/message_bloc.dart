import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:iot_api/iot_api.dart';
import 'package:iot_repository/iot_repository.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc({required this.repository}) : super(const MessageState()) {
    on<GetAllMessages>(_onGetAllMessage);
  }

  final IotRepository repository;

  Future<void> _onGetAllMessage(
    GetAllMessages event,
    Emitter<MessageState> emit,
  ) async {
    try {
      final messages = await repository.getAllMessage();
      emit(state.copyWith(messages: messages, status: MessageStatus.success));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(status: MessageStatus.failure));
    }
  }
}
