class UserModel  {
  final String userType;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final String phoneNumber;
  final String address;

  UserModel({
    required this.userType,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,
    required this.address,
  });
   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userType: json['userType'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    email: json['email'],
    password: json['password'],
    confirmPassword: json['confirmPassword'],
    phoneNumber: json['phoneNumber'],
    address: json['address'],
  );
}
