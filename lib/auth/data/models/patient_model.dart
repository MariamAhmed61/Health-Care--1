import 'package:health_care_app/auth/data/models/user_model.dart';

class PatientModel  extends UserModel {
  PatientModel({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String userType,
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
      factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        password: json['password'],
        confirmPassword: json['confirmPassword'],
       
        userType: json['userType'],
        phoneNumber: json['phoneNumber'],
        address: json['address'],
      );
} 
