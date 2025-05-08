import 'package:flutter/material.dart';
import 'package:health_care_app/auth/pressentation/screens/auht_screen/create_pasword.dart';
import 'package:health_care_app/auth/pressentation/screens/auht_screen/signup_screen.dart';
import 'package:health_care_app/auth/pressentation/screens/auht_screen/forgot_pass_screen.dart';
import 'package:health_care_app/auth/pressentation/screens/auht_screen/login_screen.dart';
import 'package:health_care_app/auth/pressentation/screens/doctor_layout/home_screen/home_screen.dart';
import 'package:health_care_app/auth/pressentation/screens/doctor_layout/notification_screen/notification_screen.dart';
import 'package:health_care_app/auth/pressentation/screens/doctor_layout/setting_screen/setting_screen.dart';
import 'package:health_care_app/auth/pressentation/screens/doctor_layout/setting_screen/wallet_screen.dart';
import 'package:health_care_app/auth/pressentation/screens/patient_layout/patient_home_screen/patient_home_screen.dart';
import 'package:health_care_app/auth/pressentation/screens/patient_layout/patient_layout_screen.dart';
import 'package:health_care_app/auth/pressentation/screens/patient_layout/patient_notification_screen/patient_notification_screen.dart';
import 'package:health_care_app/auth/pressentation/screens/patient_layout/patient_setting_screen/patient_setting_screen.dart';
import 'package:health_care_app/splash/views/splash_screen.dart';
import 'package:health_care_app/auth/pressentation/screens/auht_screen/user_selection_screen.dart';
import 'package:health_care_app/auth/pressentation/screens/auht_screen/verify_number.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );
    case UserSelection.routeName:
      return MaterialPageRoute(
        builder: (context) => const UserSelection( ),
      );
    case LoginScreen.routeName:
    final userType = settings.arguments as String ;
      return MaterialPageRoute(
        builder: (context) =>  LoginScreen(userType: userType  ),
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
   
    case SignupScreen.routeName:
        final userType = settings.arguments as String ;
      return MaterialPageRoute(
        builder: (context) =>  SignupScreen( userType: userType ),
      );
    case DoctorHomeScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const DoctorHomeScreen(),
      );
    case NotificationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const NotificationScreen(),
      );
    case SettingScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SettingScreen(),
      );
    case WalletScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const WalletScreen(),
      );

    case PatientHomeScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const PatientHomeScreen(),
      );
    case PatientNotificationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const PatientNotificationScreen(),
      );
    case PatientSettingScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const PatientSettingScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => const PatientLayoutScreen(),
      );
  }
}
