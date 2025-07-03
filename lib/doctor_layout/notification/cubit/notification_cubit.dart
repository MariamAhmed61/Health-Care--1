import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:health_care_app/doctor_layout/notification/notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  final Dio dio = Dio();
  List<NotificationModel> notifications = [];
Future<void> fetchNotifications({bool showLoading = true}) async {
  if (showLoading) emit(NotificationLoading());

  try {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('logged_in_email');

    if (email == null) throw Exception("Email not found");

    final res = await dio.get('https://healthcare-4scv.vercel.app/api/doctors/doctors');
    final doctors = res.data['data'] as List;

    final doctor = doctors.firstWhere(
      (d) => d['email'] == email,
      orElse: () => null,
    );

    if (doctor == null) throw Exception("Doctor not found");

    final doctorId = doctor['_id'];

    final response = await dio.get(
      'https://healthcare-4scv.vercel.app/api/notifications/$doctorId',
    );

    final notificationsJson = response.data['data'] as List;
    notifications = notificationsJson
        .map((e) => NotificationModel.fromJson(e))
        .toList();

    emit(NotificationLoaded(List.from(notifications)));
  } catch (e) {
    emit(NotificationError("Failed to fetch notifications"));
  }
}


  Future<bool> deleteNotification(String id) async {
    try {
      await dio.delete('https://healthcare-4scv.vercel.app/api/notifications/$id');

      notifications.removeWhere((n) => n.id == id);
      emit(NotificationLoaded(List.from(notifications)));
      return true;
    } catch (e) {
      emit(NotificationError("Failed to delete notification"));
      return false;
    }
    }
}