import '../../../data/models/doctor_response.dart';

abstract class DoctorDetailState {}

class DoctorDetailInitial extends DoctorDetailState {}

class DoctorDetailLoading extends DoctorDetailState {}

class DoctorDetailLoaded extends DoctorDetailState {
  final Doctor doctor;
  final double? latitude;
  final double? longitude;

  DoctorDetailLoaded({
    required this.doctor,
    this.latitude,
    this.longitude,
  });
}

class DoctorDetailError extends DoctorDetailState {
  final String message;
  DoctorDetailError(this.message);
}
