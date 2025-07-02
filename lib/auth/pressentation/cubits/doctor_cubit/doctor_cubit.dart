import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:health_care_app/auth/data/models/doctor_profile_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'doctor_state.dart';

class DoctorLayoutCubit extends Cubit<DoctorState> {
  DoctorLayoutCubit() : super(DoctorInitial());

  DoctorProfileModel? doctor;

  Future<DoctorProfileModel?> getDoctorProfile() async {
    emit(DoctorLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('logged_in_email');

      if (email == null || email.isEmpty) {
        emit(DoctorError('Doctor email not found'));
        return null;
      }

      final response = await Dio().get(
        'https://healthcare-4scv.vercel.app/api/doctors/doctors',
      );

      final List<dynamic> doctorsData = response.data['data'];

      final doctorData = doctorsData.firstWhere(
        (doc) => doc['email'] == email,
        orElse: () => null,
      );

      if (doctorData == null) {
        emit(DoctorError('Doctor not found with this email'));
        return null;
      }

      await prefs.setString('doctorId', doctorData['_id']);

      doctor = DoctorProfileModel.fromJson(doctorData);
      emit(DoctorLoaded(doctor!));
      return doctor;
    } catch (e) {
      emit(DoctorError("Failed to fetch doctor data"));
      return null;
    }
  }

  Future<void> updateDoctorPrice(int newPrice) async {
    emit(DoctorLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final doctorId = prefs.getString('doctorId');

      if (doctorId == null || doctorId.isEmpty) {
        emit(DoctorError("Doctor ID not found"));
        return;
      }

      await Dio().put(
        'https://healthcare-4scv.vercel.app/api/doctors/doctors/$doctorId',
        data: {
          'price': newPrice,
        },
      );

      await getDoctorProfile();
    } catch (e) {
      emit(DoctorError("Failed to update doctor price"));
    }
  }
}
