import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_care_app/auth/data/models/appointment_with_patient_model.dart';
import 'package:health_care_app/auth/data/models/patient_profile_model.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit() : super(AppointmentInitial());

  final Dio dio = Dio();
  List<AppointmentWithPatientModel> appointments = [];

  Future<void> fetchAppointmentsWithPatient() async {
    emit(AppointmentLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('logged_in_email');

      final doctorRes = await dio.get('https://healthcare-4scv.vercel.app/api/doctors/doctors');
      final allDoctors = doctorRes.data['data'] as List;
      final doctor = allDoctors.firstWhere(
            (d) => d['email'] == email,
        orElse: () => null,
      );

      if (doctor == null) throw Exception("Doctor not found");
      final doctorId = doctor['_id'];

      final appointmentRes = await dio.get(
        'https://healthcare-4scv.vercel.app/api/appointments/doctor/$doctorId',
      );
      final appointmentList = appointmentRes.data['data'] as List;

      // Get all patients
      final patientsRes = await dio.get(
        'https://healthcare-4scv.vercel.app/api/patients/patients',
      );
      final patientList = patientsRes.data['data'] as List;

      // Map appointments with patient data
      appointments = appointmentList.map((apptJson) {
        final patientId = apptJson['patientId'];
        final patientData = patientList.firstWhere(
              (p) => p['_id'] == patientId,
          orElse: () => null,
        );

        if (patientData == null) return null;

        final patient = PatientProfileModel.fromJson(patientData);

        return AppointmentWithPatientModel(
          id: apptJson['_id'],
          date: apptJson['date'],
          time: apptJson['time'],
          status: apptJson['status'],
          patient: patient,
        );
      }).whereType<AppointmentWithPatientModel>().toList();

      appointments.sort((a, b) {
        final aDateTime = DateTime.parse('${a.date} ${_normalizeTime(a.time)}');
        final bDateTime = DateTime.parse('${b.date} ${_normalizeTime(b.time)}');
        return aDateTime.compareTo(bDateTime);
      });

      emit(AppointmentLoaded(appointments));
    } catch (e) {
      emit(AppointmentError("Failed to load appointments"));
    }
  }

  String _normalizeTime(String time) {
    final parts = time.split(':');
    if (parts.length != 2) return '00:00';
    final hour = parts[0].padLeft(2, '0');
    final minute = parts[1].padLeft(2, '0');
    return '$hour:$minute';
  }
}