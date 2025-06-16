part of 'auth_cubit.dart';

@immutable
sealed class AuthStates {}

final class SignupInitial extends AuthStates {}

final class SignupSuccess extends AuthStates {}

final class SignupError extends AuthStates {
  final String message;
  SignupError(this.message);
}

final class SignupLoading extends AuthStates {}
