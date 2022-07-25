part of 'message_bloc.dart';

enum MessageStatus { loading, success, failure }

class MessageState extends Equatable {
  const MessageState({
    this.status = MessageStatus.loading,
    this.messages = const [],
  });

  final MessageStatus status;
  final List<Message> messages;

  MessageState copyWith({
    MessageStatus? status,
    List<Message>? messages,
  }) =>
      MessageState(
        status: status ?? this.status,
        messages: messages ?? this.messages,
      );

  @override
  List<Object> get props => [status, messages];
}
