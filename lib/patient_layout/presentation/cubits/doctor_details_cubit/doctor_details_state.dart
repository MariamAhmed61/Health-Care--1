import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/doctor_response.dart';

abstract class DoctorDetailState {}

class DoctorDetailInitial extends DoctorDetailState {}
class DoctorDetailLoading extends DoctorDetailState {}
class DoctorDetailLoaded extends DoctorDetailState {
  final Doctor doctor;
  DoctorDetailLoaded(this.doctor);
}
class DoctorDetailError extends DoctorDetailState {
  final String message;
  DoctorDetailError(this.message);
}