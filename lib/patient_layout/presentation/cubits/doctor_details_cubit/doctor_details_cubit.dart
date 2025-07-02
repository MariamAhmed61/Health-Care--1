import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:health_care_app/patient_layout/data/services/patient_service.dart';
import 'doctor_details_state.dart';

class DoctorDetailCubit extends Cubit<DoctorDetailState> {
  DoctorDetailCubit() : super(DoctorDetailInitial());

  void fetchDoctor(String id) async {
    emit(DoctorDetailLoading());
    try {
      final doctor = await PatientService.getDoctorById(id);

      if (doctor != null) {
        double? lat;
        double? lng;

        // Get coordinates if address is valid
        if (doctor.address != null && doctor.address!.isNotEmpty) {
          log("Fetching coordinates for address: ${doctor.address}");
          try {
            final locations = await locationFromAddress(doctor.address!);
            if (locations.isNotEmpty) {
              lat = locations.first.latitude;
              lng = locations.first.longitude;
            }
            log(lat.toString());
            log(lng.toString());
          } catch (e) {
            log("Geocoding failed: $e");
          }
        }

        emit(DoctorDetailLoaded(
          doctor: doctor,
          latitude: lat,
          longitude: lng,
        ));
      } else {
        emit(DoctorDetailError('Failed to load doctor details'));
      }
    } catch (e) {
      emit(DoctorDetailError('Error: $e'));
    }
  }

  void rateDoctor({
    required String doctorId,
    required int rating,
    required String userId,
  }) async {
    try {
      emit(DoctorDetailLoading());
      final success = await PatientService.rateDoctor(
        doctorId: doctorId,
        rating: rating,
        userId: userId,
      );

      if (success) {
        fetchDoctor(doctorId);
      } else {
        emit(DoctorDetailError("فشل في إرسال التقييم"));
      }
    } catch (e) {
      emit(DoctorDetailError("خطأ أثناء إرسال التقييم: $e"));
    }
  }

}
