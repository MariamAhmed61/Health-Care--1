part of 'auth_cubit.dart';

@immutable
sealed class AuthStates {}

final class AuthInitial extends AuthStates {}

final class AuthSuccess extends AuthStates {
 
}

final class AuthError extends AuthStates {
  final String message;
  AuthError(this.message);
}

final class AuthLoading extends AuthStates {}
final class AuthCodeSent extends AuthStates {
  final String code;
  AuthCodeSent(this.code);
}
