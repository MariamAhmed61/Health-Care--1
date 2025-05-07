class PatientModel {
  final String userType = 'Patient';
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final String confirmPassword;
  final String address;
  PatientModel({
    required this.address, 
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  });
  factory PatientModel.fromJson(Map json) {
    return PatientModel(
      address: json['address'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
    );
  }
}