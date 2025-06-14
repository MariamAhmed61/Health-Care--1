class UserModel {
  final String? specialization;
  final String? userType;
  final String firstName;
  final String lastName;
  final String email;
  final String? phoneNumber;
  final String? address;
  final String? password;
  final String? confirmPassword;

  UserModel({
    this.specialization,
    this.userType,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
    this.address,
    this.password,
    this.confirmPassword,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
  specialization: json['specialization'],
  userType: json['userType'],
  firstName: json['firstName'],
  lastName: json['lastName'],
  email: json['email'],
  phoneNumber: json['phoneNumber'],
  address: json['address'],
  password: '',          // مش بيرجع من السيرفر
  confirmPassword: '',   // مش بيرجع من السيرفر
);
}
