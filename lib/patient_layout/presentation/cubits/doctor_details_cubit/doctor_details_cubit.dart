import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/patient_layout/data/services/patient_service.dart';

import 'doctor_details_state.dart';

class DoctorDetailCubit extends Cubit<DoctorDetailState> {
  DoctorDetailCubit() : super(DoctorDetailInitial());

  void fetchDoctor(String id) async {
    emit(DoctorDetailLoading());
    try {
      final doctor = await PatientService.getDoctorById(id);
      if (doctor != null) {
        emit(DoctorDetailLoaded(doctor));
      } else {
        emit(DoctorDetailError('Failed to load doctor details'));
      }
    } catch (e) {
      emit(DoctorDetailError('Error: $e'));
    }
  }
}