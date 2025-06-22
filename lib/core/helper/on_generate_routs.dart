import 'package:flutter/material.dart';
import 'package:health_care_app/auth/pressentation/screens/auht_screen/create_pasword.dart';
import 'package:health_care_app/auth/pressentation/screens/auht_screen/signup_screen.dart';
import 'package:health_care_app/auth/pressentation/screens/auht_screen/forgot_pass_screen.dart';
import 'package:health_care_app/auth/pressentation/screens/auht_screen/login_screen.dart';
import 'package:health_care_app/doctor_layout/doctor_layout_screen.dart';
import 'package:health_care_app/doctor_layout/home_screen/home_screen.dart';
import 'package:health_care_app/doctor_layout/notification_screen/notification_screen.dart';
import 'package:health_care_app/doctor_layout/setting_screen/setting_screen.dart';
import 'package:health_care_app/doctor_layout/setting_screen/wallet_screen.dart';
import 'package:health_care_app/patient_layout/presentation/screens/home/patient_home_screen.dart';
import 'package:health_care_app/patient_layout/presentation/screens/layout/patient_layout_screen.dart';
import 'package:health_care_app/patient_layout/presentation/screens/notification/patient_notification_screen.dart';
import 'package:health_care_app/patient_layout/presentation/screens/profile/patient_profile.dart';
import 'package:health_care_app/patient_layout/presentation/screens/settings/patient_setting_screen.dart';
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
        builder: (context) => const UserSelection(),
      );
    case LoginScreen.routeName:
      final userType = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => LoginScreen(userType: userType),
      );
    case CreatePassword.routeName:
      Map<String, dynamic> arguments =
          settings.arguments as Map<String, dynamic>;
      final phoneNumber = arguments['phoneNumber'] as String;
      final userType = arguments['userType'] as String;
      final code = arguments['code'] as String;
      return MaterialPageRoute(
        builder: (context) => CreatePassword(
          phoneNumber: phoneNumber,
          userType: userType,
          code: code,
        ),
      );
    case ForgotPassword.routeName:
      final userType = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => ForgotPassword(
          userType: userType,
        ),
      );
    case VerifyNumber.routeName:
      Map<String, dynamic> arguments =
          settings.arguments as Map<String, dynamic>;
      final phoneNumber = arguments['phoneNumber'] as String;
      final userType = arguments['userType'] as String;
      final code = arguments['code'] as String;

      return MaterialPageRoute(
        builder: (context) => VerifyNumber(
          phoneNumber: phoneNumber,
          userType: userType,
          code: code,
        ),
      );

    case SignupScreen.routeName:
      final userType = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => SignupScreen(userType: userType),
      );
    case DoctorHomeScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const DoctorHomeScreen(),
      );
    case DoctorLayoutScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const DoctorLayoutScreen(),
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
    case PatientProfile.routeName:
      return MaterialPageRoute(builder: (context)=>const PatientProfile());

    default:
      return MaterialPageRoute(
        builder: (context) => const PatientLayoutScreen(),
      );
  }
}
