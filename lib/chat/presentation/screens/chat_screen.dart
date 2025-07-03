import 'dart:async';
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

  Timer? _pollingTimer; // حطيه فوق في الكلاس علشان نوقفه بعدين لو حبينا

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<MessageCubit>().loadConversation(
            widget.senderId,
            widget.receiverId,
            showLoading: true,
          );

      _pollingTimer = Timer.periodic(const Duration(seconds: 3), (_) {
        context.read<MessageCubit>().loadConversation(
              widget.senderId,
              widget.receiverId,
              showLoading: false,
            );
      });
    });
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
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
    final messageDate = DateTime.tryParse(message.timestamp);
    final formattedTime = messageDate != null
        ? "${messageDate.hour}:${messageDate.minute.toString().padLeft(2, '0')}"
        : '';

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft:
                isMe ? const Radius.circular(12) : const Radius.circular(0),
            bottomRight:
                isMe ? const Radius.circular(0) : const Radius.circular(12),
          ),
        ),
        constraints: const BoxConstraints(
          maxWidth: 280, // تمنع الرسالة من أنها تاخد الشاشة كلها
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.content,
              style: TextStyle(
                fontSize: 16,
                color: isMe ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              formattedTime,
              style: TextStyle(
                fontSize: 10,
                color: isMe ? Colors.white70 : Colors.black54,
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
