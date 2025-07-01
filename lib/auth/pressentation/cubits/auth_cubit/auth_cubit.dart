import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/auth/data/models/user_model.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_care_app/auth/data/services/auth_service.dart';
import 'package:health_care_app/auth/data/models/doctor_profile_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthService _authService;

  AuthCubit(this._authService) : super(AuthInitial());

  Future<UserModel?> login(String email, String password, String userType) async {
    emit(AuthLoading());
    try {
      final response = await _authService.login(email, password, userType);
      final UserModel? user = response;

      if (user == null) {
        throw Exception("User is null");
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', user.email);
      await prefs.setString('firstName', user.firstName);
      await prefs.setString('lastName',user.lastName);

      log('User from response: $user');

      emit(AuthSuccess(
        user: user,
      ));
    } catch (e) {
      log(' Login error: $e');
      emit(AuthError(e.toString()));
    }
  }

  Future<UserModel?> signup({
    String? specialization,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String confirmPassword,
    required String phoneNumber,
    required String address,
    required String userType,
  }) async {
    emit(AuthLoading());
    try {
      await _authService.signup(
        specialization: specialization,
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        confirmPassword: confirmPassword,
        phoneNumber: phoneNumber,
        address: address,
        userType: userType,
      );

      UserModel? user = UserModel(firstName: firstName, lastName: lastName, email: email);

      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}