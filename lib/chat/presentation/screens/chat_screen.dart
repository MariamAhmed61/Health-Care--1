import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/chat/data/message_model.dart';
import 'package:health_care_app/chat/data/message_service.dart';
import 'package:health_care_app/chat/presentation/cubit/message_cubit.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = 'chat-screen';
  final String senderId;
  final String receiverId;
  final String senderType;
  final String receiverType;

  const ChatScreen({
    super.key,
    required this.senderId,
    required this.receiverId,
    required this.senderType,
    required this.receiverType,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context
        .read<MessageCubit>()
        .loadConversation(widget.senderId, widget.receiverId);
  }

  void _sendMessage() async {
  final text = _controller.text.trim();
  if (text.isEmpty) return;
  
  await context.read<MessageCubit>().sendMessage(
    senderId: widget.senderId,
    receiverId: widget.receiverId,
    senderType: widget.senderType,
    receiverType: widget.receiverType,
    content: text,
  );

  _controller.clear();

  // Scroll to bottom بعد ما تتبعت الرسالة وتتجاب
  Future.delayed(const Duration(milliseconds: 300), () {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  });
}


  Widget _buildMessageBubble(MessageModel message) {
    final isMe = message.senderId == widget.senderId;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message.content,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: AppColors.primaryColor,
      title: const Text(
        "Chat",
        style: TextStyle(color: Colors.white),
      ),
    ),
    body: Column(
      children: [
        Expanded(
          child: BlocBuilder<MessageCubit, MessageState>(
            builder: (context, state) {
              if (state is MessageLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MessageLoaded) {
                final messages = state.messages;
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return _buildMessageBubble(messages[index]);
                  },
                );
              } else if (state is MessageError) {
                log(state.error);
                return Center(child: Text("Error: ${state.error}"));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "type your message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed:  _sendMessage,
                  icon: const Icon(Icons.send, color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
}