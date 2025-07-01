import 'package:health_care_app/auth/data/models/user_model.dart';

class DoctorModel extends UserModel {
  final String specialization;

  DoctorModel({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String userType,
    required this.specialization,
    required String phoneNumber,
    required String address,
  }) : super(
    firstName: firstName,
    lastName: lastName,
    email: email,
    password: password,
    confirmPassword: confirmPassword,
    userType: userType,
    phoneNumber: phoneNumber,
    address: address,
  );
  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
    firstName: json['firstName'],
    lastName: json['lastName'],
    email: json['email'],
    password: json['password'],
    confirmPassword: json['confirmPassword'],
    userType: json['userType'],
    specialization: json['specialization'],
    phoneNumber: json['phoneNumber'],
    address: json['address'],
  );
}