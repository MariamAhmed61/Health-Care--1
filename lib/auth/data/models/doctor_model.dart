class DoctorModel {
  final String userType = 'doctor';
  final String firstName;
  final String lastName;
  final String email;
  final String ?image;
  final String specialization;
  final String password;
  final String confirmPassword;
  final String phoneNumber;
  final String address;

  DoctorModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
    required this.specialization,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,
    required this.address,
  });
  factory DoctorModel.fromJson(Map json) {
    return DoctorModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      image: json['image'],
      specialization: json['specialization'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
    );
  }
} 