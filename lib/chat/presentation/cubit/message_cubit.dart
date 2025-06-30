import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/chat/data/message_model.dart';
import 'package:health_care_app/chat/data/message_service.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final MessageService messageService;

  MessageCubit(this.messageService) : super(MessageInitial());

  Future<void> loadConversation(String user1, String user2) async {
    emit(MessageLoading());
    try {
      final messages = await messageService.getConversation(
        user1: user1,
        user2: user2,
      );
      emit(MessageLoaded(messages));
    } catch (e) {
      emit(MessageError(e.toString()));
    }
  }

  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String senderType,
    required String receiverType,
    required String content,
  }) async {
    try {
      await messageService.sendMessage(
        senderId: senderId,
        receiverId: receiverId,
        senderType: senderType,
        receiverType: receiverType,
        content: content,
      );

      // من غير MessageLoading هنا
      final updatedMessages = await messageService.getConversation(
        user1: senderId,
        user2: receiverId,
      );
      emit(MessageLoaded(updatedMessages));
    } catch (e) {
      emit(MessageError(e.toString()));
    }
  }
}
