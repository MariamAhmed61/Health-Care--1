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
      Response response = await _dio.post('${_dio.options.baseUrl}/auth/login',
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

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['error']['message'] ?? 'oops something went wrong';
      throw Exception(errorMessage);
    } catch (e) {
      log(e.toString());
      throw Exception('oops something went wrong');
    }
  }
}
