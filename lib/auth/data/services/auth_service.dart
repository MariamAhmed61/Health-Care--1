import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:health_care_app/auth/data/models/user_model.dart';
 import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:health_care_app/auth/pressentation/screens/auht_screen/forgot_pass_screen.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://healthcare-xi-pied.vercel.app/api',
    ),
  );

  Future<String> login(String email, String password, String userType) async {
    try {
      Response response = await _dio.post(
        '${_dio.options.baseUrl}/auth/login',
        data: {'email': email, 'password': password, 'userType': userType},
      );

      if (response.statusCode == 200) {
        return 'success';
      } else {
        return 'failed';
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'oops something went wrong';
      throw Exception(errorMessage);
    } catch (e) {
      log('Login error: $e');
      throw Exception('oops something went wrong');
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Register success');
      } else {
        print('Register failed with status code: ${response.statusCode}');
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


  Future<Map<String, dynamic>> sendCode(String phoneNumber , String userType) async {
    try {
      Response response = await _dio.post(
        '${_dio.options.baseUrl}/auth/forgot-password',
        data: {'phoneNumber': phoneNumber, 'userType': userType},
      );
      
      return response.data;
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

