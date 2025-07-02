import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/auth/data/models/doctor_profile_model.dart';
import 'package:health_care_app/auth/data/models/user_model.dart';
import 'package:health_care_app/auth/data/services/auth_service.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(this._authService) : super(AuthInitial());
  final AuthService _authService;
  Future<void> signup(
      {String? specialization,
      required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String confirmPassword,
      required String phoneNumber,
      required String address,
      required String userType}) async {
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
      UserModel? user =
          UserModel(firstName: firstName, lastName: lastName, email: email);

      emit(AuthSuccess(user: user));
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<UserModel?> login(
      String email, String password, String userType) async {
    emit(AuthLoading());
    try {
      final response = await _authService.login(email, password, userType);
      final UserModel? user = response;

      if (user == null) {
        throw Exception("User is null");
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', user.email);
      await prefs.setString('userType', user.userType ?? '');
      await prefs.setString('firstName', user.firstName);
      await prefs.setString('lastName', user.lastName);
      await prefs.setString('logged_in_email', user.email); // لازم ده

      log('👤 User from response: $user');

      emit(AuthSuccess(
        user: user,
      ));
    } catch (e) {
      log(' Login error: $e');
      emit(AuthError(e.toString()));
    }
  }

  Future<void> sendCode(String phoneNumber, String userType) async {
    emit(AuthLoading());
    try {
      Map<String, dynamic> response =
          await _authService.sendCode(phoneNumber, userType);
      String code = response['code'];
      emit(AuthCodeSent(code));
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> resetPassword(String newPassword, String phoneNumber,
    String userType, String code) async {
  emit(AuthLoading());
  try {
    await _authService.resetPassword(
      newPassword, phoneNumber, userType, code,
    );

    emit(AuthSuccess()); // أو أي حالة مناسبة عندك
  } on Exception catch (e) {
    emit(AuthError(e.toString()));
  }
}

}
