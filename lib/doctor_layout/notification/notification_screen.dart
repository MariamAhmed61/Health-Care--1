import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:health_care_app/doctor_layout/notification/cubit/notification_cubit.dart';
import 'package:health_care_app/doctor_layout/notification/notification_model.dart';
import 'package:health_care_app/generated/l10n.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = 'doctornotification';

  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notificationsLocal = [];
  Timer? _pollingTimer;
  @override
  @override
  void initState() {
    super.initState();

    // أول تحميل = بعرض loading
    context.read<NotificationCubit>().fetchNotifications();

    // بعدها polling بدون loading indicator
    _pollingTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      context.read<NotificationCubit>().fetchNotifications(showLoading: false);
    });
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }

  double calculateMaxMessageHeight(
      List<String> messages, TextStyle style, double maxWidth) {
    double maxHeight = 0;
    for (var message in messages) {
      final tp = TextPainter(
        text: TextSpan(text: message, style: style),
        textDirection: TextDirection.ltr,
        maxLines: null,
      );
      tp.layout(maxWidth: maxWidth);
      if (tp.height > maxHeight) {
        maxHeight = tp.height;
      }
    }
    return maxHeight + 32;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(
                child:
                    CircularProgressIndicator(color: AppColors.primaryColor));
          } else if (state is NotificationLoaded) {
            final textStyle =
                const TextStyle(color: Colors.white, fontSize: 16);
            final screenWidth = MediaQuery.of(context).size.width;
            final cardPadding = 32.0;
            final availableWidth = screenWidth - cardPadding;

            if (notificationsLocal.isEmpty ||
                notificationsLocal.length != state.notifications.length) {
              notificationsLocal = List.from(state.notifications);
            }

            final messages = notificationsLocal.map((e) => e.message).toList();
            final maxHeight =
                calculateMaxMessageHeight(messages, textStyle, availableWidth);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    S.of(context).notification,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: notificationsLocal.length,
                    itemBuilder: (context, index) {
                      final notification = notificationsLocal[index];
                      return Dismissible(
                        key: Key(notification.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          color: Colors.grey,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        confirmDismiss: (_) async {
                          final success = await context
                              .read<NotificationCubit>()
                              .deleteNotification(notification.id);
                          if (success && mounted) {
                            setState(() {
                              notificationsLocal.removeAt(index);
                            });
                          }
                          return success;
                        },
                        child: SizedBox(
                          height: 130,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.notifications_active,
                                    color: Colors.white),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    notification.message,
                                    style: textStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is NotificationError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
