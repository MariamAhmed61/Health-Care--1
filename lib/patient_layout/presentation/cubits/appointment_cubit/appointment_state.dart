abstract class AppointmentState {}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentLoaded extends AppointmentState {
  final String message;
  AppointmentLoaded(this.message);
}

class AppointmentError extends AppointmentState {
  final String message;
  AppointmentError(this.message);
}

class AppointmentTimesLoaded extends AppointmentState {
  final List<String> times;
  AppointmentTimesLoaded(this.times);
}

class PatientAppointmentsLoaded extends AppointmentState {
  final List<Map<String, dynamic>> appointments;
  PatientAppointmentsLoaded(this.appointments);
}
