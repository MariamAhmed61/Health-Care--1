import 'package:dio/dio.dart';
import 'message_model.dart';

class MessageService {
  final Dio dio;
  final String baseUrl;

  MessageService({this.baseUrl = 'https://healthcare-4scv.vercel.app/api/messages'})
      : dio = Dio();

  // إرسال رسالة
  Future<void> sendMessage(Message message) async {
    try {
      final response = await dio.post(
        '$baseUrl/send',
        data: {
          'senderId': message.senderId,
          'receiverId': message.receiverId,
          'senderType': message.senderType,
          'receiverType': message.receiverType,
          'content': message.content,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to send message');
      }
    } catch (e) {
      throw Exception('Failed while trying to send message: $e');
    }
  }

  // تحميل المحادثة
  Future<List<Message>> fetchConversation(String user1, String user2) async {
    try {
      final response = await dio.get('$baseUrl/conversation', queryParameters: {
        'user1': user1,
        'user2': user2,
      });

      if (response.statusCode == 200) {
        final data = response.data['data']['messages'] as List;
        return data.map((message) => Message.fromJson(message)).toList();
      } else {
        throw Exception('failed to load conversation');
      }
    } catch (e) {
      throw Exception('failed while loading conversation: $e');
    }
  }
}
