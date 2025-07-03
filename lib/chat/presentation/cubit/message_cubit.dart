import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/chat/data/message_model.dart';
import 'package:health_care_app/chat/data/message_service.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final MessageService messageService;

  MessageCubit(this.messageService) : super(MessageInitial());

  Future<void> loadConversation(String user1, String user2,
      {bool showLoading = true}) async {
    try {
      if (showLoading) emit(MessageLoading());

      final conversation = await messageService.fetchConversation(user1, user2);
      emit(MessageLoaded(conversation));
    } catch (e) {
      emit(MessageError('Failed to load conversation: $e'));
    }
  }

  // Send a message
  Future<void> sendMessage(Message message) async {
    try {
      await messageService.sendMessage(message);

      if (state is MessageLoaded) {
        final updatedMessages =
            List<Message>.from((state as MessageLoaded).messages)..add(message);
        emit(MessageLoaded(updatedMessages));
      }
    } catch (e) {
      emit(MessageError('Failed to send message: $e'));
    }
  }
}
