import 'package:dio/dio.dart';
import 'package:health_care_app/chat/data/message_model.dart';


import 'package:dio/dio.dart';

class MessageService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://healthcare-4scv.vercel.app/api/messages',
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  Future<List<MessageModel>> getConversation({
  required String user1,
  required String user2,
}) async {
  final response = await _dio.get(
    '/conversation',
    queryParameters: {
      'user1': user1.trim(),
      'user2': user2.trim(),
    },
  );

  if (response.data['status'] == 'success') {
    final List<dynamic> data = response.data['data'];

    return data.map((e) {
      return MessageModel(
        senderId: user1, // مؤقتًا نستخدم الـ user1
        receiverId: user2,
        content: e.toString(), // لأن الـ e عبارة عن String
        createdAt: DateTime.now(), // مؤقت
      );
    }).toList();
  } else {
    throw Exception('Failed to load conversation: ${response.data['message']}');
  }
}


  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String senderType,
    required String receiverType,
    required String content,
  }) async {
    final response = await _dio.post(
      '/send',
      data: {
        'senderId': senderId,
        'receiverId': receiverId,
        'senderType': senderType,
        'receiverType': receiverType,
        'content': content, 
      },
    );

    if (response.data['status'] != 'success') {
      throw Exception('Failed to send message: ${response.data['message']}');
    }
  }
}
