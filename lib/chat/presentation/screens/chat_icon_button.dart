import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/auth/pressentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:health_care_app/chat/data/message_service.dart';
import 'package:health_care_app/chat/presentation/cubit/message_cubit.dart';
import 'package:health_care_app/chat/presentation/screens/chat_screen.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';

class ChatIconButton extends StatelessWidget {
  const ChatIconButton({
    Key? key,
    required this.doctorId,
  }) : super(key: key);

  final String doctorId;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.chat,
        color: AppColors.primaryColor,
      ),
     onPressed: () {
  final authState = context.read<AuthCubit>().state;

  if (authState is AuthSuccess) {
    final senderId = authState.user.id;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => MessageCubit(MessageService())
            ..loadConversation(senderId, doctorId),
          child: ChatScreen(
            senderId: senderId as String,
            receiverId: doctorId,
            senderType: 'Patient',
            receiverType: 'Doctor',
          ),
        ),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('You must be logged in to chat with a doctor.'),
      ),
    );
  }
},

    );
  }
}
