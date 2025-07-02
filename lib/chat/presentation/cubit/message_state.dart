part of 'message_cubit.dart';

abstract class MessageState {
  
}

class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {}

class MessageLoaded extends MessageState {
  final List<Message> messages;

  MessageLoaded(this.messages);
}

class MessageSent extends MessageState {
  final Message message;

  MessageSent(this.message);
}

class MessageError extends MessageState {
  final String error;

  MessageError(this.error);
}
