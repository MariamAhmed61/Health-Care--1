import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/auth/data/models/user_model.dart';
import 'package:health_care_app/auth/data/services/auth_service.dart';
import 'package:meta/meta.dart';

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
      emit(AuthSuccess());
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> login(String email, String password , String userType) async {
    emit(AuthLoading());
    try {
      await _authService.login(email, password, userType );
      emit(AuthSuccess());
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
