import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/chat/data/message_model.dart';
import 'package:health_care_app/chat/data/message_service.dart';
import 'package:health_care_app/chat/presentation/cubit/message_cubit.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:health_care_app/generated/intl/messages_ar.dart';

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
    // استدعي الدالة هنا بعد بناء الـ context
    Future.microtask(() {
      context.read<MessageCubit>().loadConversation(
            widget.senderId,
            widget.receiverId,
          );
    });
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    log(widget.senderType);
    if (text.isEmpty) return;

    await context.read<MessageCubit>().sendMessage(Message(
          senderId: widget.senderId,
          receiverId: widget.receiverId,
          senderType: widget.senderType,
          receiverType: widget.receiverType,
          content: text,
          timestamp: DateTime.now()
              .toIso8601String(), // Ensure the timestamp is included
        ));

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

  Widget _buildMessageBubble(Message message) {
    final isMe = message.senderId == widget.senderId;
    final messageDate = DateTime.parse(message.timestamp);
    final formattedTime =
        "${messageDate.hour}:${messageDate.minute.toString().padLeft(2, '0')}"; // Display only the time (hour:minute)

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        padding: const EdgeInsets.all(10),
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width *
                0.75), // Ensure the bubble doesn't take full width
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(
                height: 4), // Add space between the message and the time
            Text(
              formattedTime, // Display only the time (not date)
              style: TextStyle(
                color: isMe ? Colors.white70 : Colors.black54,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

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
                  return const Center(
                      child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ));
                } else if (state is MessageLoaded) {
                  final messages = state.messages;
                  return ListView.builder(
                    controller: _scrollController,
                    reverse: true, // Display messages from bottom to top
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
                    onPressed: _sendMessage,
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
