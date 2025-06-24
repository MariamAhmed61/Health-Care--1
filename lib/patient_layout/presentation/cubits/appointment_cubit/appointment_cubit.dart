import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/doctor_response.dart';
import 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit() : super(AppointmentInitial());

  void bookAppointment(Doctor doctor) async {
    emit(AppointmentLoading());
    try {
      // Simulate API call for booking (replace with actual API endpoint)
      await Future.delayed(const Duration(seconds: 1)); // Placeholder
      emit(AppointmentSuccess('Appointment booked successfully with Dr. ${doctor.firstName}'));
    } catch (e) {
      emit(AppointmentError('Failed to book appointment: $e'));
    }
  }
}