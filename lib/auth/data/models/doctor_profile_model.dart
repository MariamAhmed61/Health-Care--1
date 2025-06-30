class DoctorProfileModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String specialization;
  final String address;
  final double averageRating;
  final int price;
  final int balance;

  DoctorProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.specialization,
    required this.address,
    required this.averageRating,
    required this.price,
    required this.balance,
  });

  String get fullName => '$firstName $lastName';

  factory DoctorProfileModel.fromJson(Map<String, dynamic> json) {
    return DoctorProfileModel(
        id: json['_id'] ?? '',
        firstName: json['firstName'] ?? '',
        lastName: json['lastName'] ?? '',
        email: json['email'] ?? '',
        phoneNumber: json['phoneNumber'] ?? '',
        specialization: json['specialization'] ?? '',
        address: json['address'] ?? '',
        averageRating: double.tryParse(json['averageRating']?.toString() ?? '0.0') ?? 0.0,
        price: json['price'] ?? 0,
        balance: json['balance'] ??0,
    );
  }
}