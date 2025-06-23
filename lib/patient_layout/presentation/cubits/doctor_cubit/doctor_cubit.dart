
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/patient_layout/data/services/patient_service.dart';

import 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit() : super(DoctorInitial());

  void fetchDoctors() async {
    emit(DoctorLoading());
    try {
      final doctors = await PatientService.getDoctors();
      if (doctors != null) {
        emit(DoctorLoaded(doctors));
      } else {
        emit(DoctorError('Failed to load doctors'));
      }
    } catch (e) {
      emit(DoctorError('Error: $e'));
    }
  }
}