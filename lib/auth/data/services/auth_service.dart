import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:health_care_app/auth/data/models/user_model.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://healthcare-4scv.vercel.app/api',
    ),
  );

  Future<UserModel?> login(String email, String password, String userType) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
          'userType': userType,
        },
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data['user']);
      } else {
        throw Exception('Login failed');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? 'Oops, something went wrong';
      throw Exception(errorMessage);
    } catch (e) {
      log('Login error: $e');
      throw Exception('Oops, something went wrong');
    }
  }

  Future<void> signup({
    String? specialization,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
    required String address,
    required String userType,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/register',
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Register success');
      } else {
        print('Register failed: ${response.statusCode}');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? 'Oops, something went wrong';
      throw Exception(errorMessage);
    } catch (e) {
      log('Signup error: $e');
      throw Exception('Oops, something went wrong');
    }
  }
}