import 'appointment_model.dart';
import 'patient_profile_model.dart';

class AppointmentWithPatientModel {
  final String id;
  final String date;
  final String time;
  final String status;
  final PatientProfileModel patient;

  AppointmentWithPatientModel({
  required this.id,
  required this.date,
  required this.time,
  required this.status,
  required this.patient,
  });
}