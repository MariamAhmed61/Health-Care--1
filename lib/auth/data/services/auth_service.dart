import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:health_care_app/auth/data/models/user_model.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://healthcare-xi-pied.vercel.app/api',
    ),
  );

  Future<UserModel?> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        '${_dio.options.baseUrl}/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['error']['message'] ?? 'oops something went wrong';
      throw Exception(errorMessage);
    } catch (e) {
      log('Login error: $e');
      throw Exception('oops something went wrong');
    }
  }

  Future<UserModel?> signup({
    String? specialization,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
    required String address,
    required String userType, // doctor / patient
  }) async {
    try {
      Response response = await _dio.post(
        '${_dio.options.baseUrl}/auth/register',
        data: {
          'specialization': specialization,
          'firstName': firstName,
          'lastName': lastName,
          'confirmPassword': confirmPassword,
          'email': email,
          'password': password,
          'userType': userType,
          'phoneNumber': phoneNumber,
          'address': address,
        },
      );
      if (response.data['status'] != 'success') {
      throw Exception('Signup failed: Unexpected response');
    }

    // ✅ Registration succeeded, no need to return anything
  } on DioException catch (e) {
    final errorMessage =
        e.response?.data['message'] ?? 'Oops, something went wrong';
    throw Exception(errorMessage);
  } catch (e) {
    log('Signup error: $e');
    throw Exception('Oops, something went wrong');
  }
  }
}
