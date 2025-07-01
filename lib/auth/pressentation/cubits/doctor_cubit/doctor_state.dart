part of 'doctor_cubit.dart';

@immutable
sealed class DoctorState {}

final class DoctorInitial extends DoctorState {}

final class DoctorLoading extends DoctorState {}

final class DoctorSuccess extends DoctorState {}

final class DoctorLoaded extends DoctorState {
  final DoctorProfileModel doctor;

  DoctorLoaded(this.doctor);
}

final class DoctorError extends DoctorState {
  final String message;
  DoctorError(this.message);
}