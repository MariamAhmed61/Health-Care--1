import 'package:flutter/material.dart';
import 'package:health_care_app/auth/pressentation/screens/create_pasword.dart';
import 'package:health_care_app/auth/pressentation/screens/doctor_signup.dart';
import 'package:health_care_app/auth/pressentation/screens/forgot_pass_screen.dart';
import 'package:health_care_app/auth/pressentation/screens/login_screen.dart';
import 'package:health_care_app/splash/splash_screen.dart';
import 'package:health_care_app/auth/pressentation/screens/user_selection_screen.dart';
import 'package:health_care_app/auth/pressentation/screens/user_signup.dart';
import 'package:health_care_app/auth/pressentation/screens/verify_number.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );
    case UserSelection.routeName:
      return MaterialPageRoute(
        builder: (context) => const UserSelection(),
      );
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case CreatePassword.routeName:
      return MaterialPageRoute(
        builder: (context) => const CreatePassword(),
      );
    case ForgotPassword.routeName:
      return MaterialPageRoute(
        builder: (context) => const ForgotPassword(),
      );
    case VerifyNumber.routeName:
      return MaterialPageRoute(
        builder: (context) => VerifyNumber(),
      );
    case UserSignup.routeName:
      return MaterialPageRoute(
        builder: (context) => const UserSignup(),
      );
    case DoctorSignup.routeName:
      return MaterialPageRoute(
        builder: (context) => const DoctorSignup(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );
  }
}
