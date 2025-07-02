import 'package:flutter_bloc/flutter_bloc.dart';
import 'appointment_state.dart';
import 'package:dio/dio.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit() : super(AppointmentInitial());

  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://healthcare-4scv.vercel.app/api',
    headers: {"Content-Type": "application/json"},
  ));

  Future<void> fetchDoctorTimes(String doctorId, String date) async {
    emit(AppointmentLoading());
    try {
      final response = await _dio.get('/doctors/doctors/$doctorId');
      final allSlots = response.data['data']['availableSlots'] as List;

      final todaySlot = allSlots.firstWhere(
        (slot) => slot['date'] == date,
        orElse: () => null,
      );

      if (todaySlot != null) {
        final times = List<String>.from(todaySlot['times']);
        emit(AppointmentTimesLoaded(times));
      } else {
        emit(AppointmentTimesLoaded([]));
      }
    } catch (e) {
      emit(AppointmentError("فشل في تحميل المواعيد"));
    }
  }

  Future<void> fetchPatientAppointments(String patientId) async {
    emit(AppointmentLoading());
    try {
      final response = await _dio.get(
        'https://healthcare-4scv.vercel.app/api/appointments/patient/$patientId',
      );

      final appointments =
          List<Map<String, dynamic>>.from(response.data['data'] ?? []);

      emit(PatientAppointmentsLoaded(appointments));
    } catch (e) {
      emit(AppointmentError('فشل في تحميل المواعيد: $e'));
    }
  }

  Future<void> bookAppointment({
    required String doctorId,
    required String patientId,
    required String date,
    required String time,
    required String paymentMethod,
  }) async {
    emit(AppointmentLoading());
    try {
      final response = await _dio.post(
          'https://healthcare-4scv.vercel.app/api/appointments/book',
          data: {
            "doctorId": doctorId,
            "patientId": patientId,
            "date": date,
            "time": time,
            "paymentMethod": paymentMethod,
          });

      if (response.statusCode == 200) {
        emit(AppointmentLoaded(response.data["message"] ?? "تم الحجز بنجاح"));
      } else {
        emit(AppointmentError("فشل الحجز"));
      }
    } catch (e) {
      emit(AppointmentError("حدث خطأ أثناء الحجز"));
    }
  }
}
