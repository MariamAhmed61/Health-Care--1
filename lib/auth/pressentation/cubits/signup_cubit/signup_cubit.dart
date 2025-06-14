import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/auth/data/models/user_model.dart';
import 'package:health_care_app/auth/data/services/auth_service.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this._authService) : super(SignupInitial());
  final AuthService _authService;
  UserModel? userModel;
     static SignupCubit get(context) => BlocProvider.of(context);
  Future<void> signup(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String confirmPassword,
      required String phoneNumber,
      required String address,
      required String userType}) async {
    emit(SignupLoading());
    try {
      userModel = await _authService.signup(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        confirmPassword: confirmPassword,
        phoneNumber: phoneNumber,
        address: address,
        userType: userType,
      );
      emit(SignupSuccess(
         userModel!,
      ));
    } catch (e) {
      emit(SignupError(e.toString()));
    }
  }
}
