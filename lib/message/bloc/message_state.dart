part of 'message_bloc.dart';

enum MessageStatus {loading, success}

class MessageState extends Equatable {
  const MessageState({
    this.status = MessageStatus.loading,
  });
  
  final MessageStatus status;
  
  @override
  List<Object> get props => [status];
}
