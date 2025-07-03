import 'package:flutter/material.dart';
import 'package:health_care_app/auth/pressentation/screens/auht_screen/create_pasword.dart';
import 'package:health_care_app/auth/pressentation/screens/auht_screen/signup_screen.dart';
import 'package:health_care_app/auth/pressentation/screens/auht_screen/forgot_pass_screen.dart';
import 'package:health_care_app/auth/pressentation/screens/auht_screen/login_screen.dart';
import 'package:health_care_app/chat/presentation/screens/chat_screen.dart';
import 'package:health_care_app/doctor_layout/doctor_layout_screen.dart';
import 'package:health_care_app/doctor_layout/home_screen/home_screen.dart';
import 'package:health_care_app/doctor_layout/notification/notification_screen.dart';
import 'package:health_care_app/doctor_layout/setting_screen/change_password_screen.dart';
import 'package:health_care_app/doctor_layout/setting_screen/help_support_screen.dart';
import 'package:health_care_app/doctor_layout/setting_screen/setting_screen.dart';
import 'package:health_care_app/doctor_layout/setting_screen/wallet_screen.dart';
import 'package:health_care_app/patient_layout/presentation/screens/home/patient_home_screen.dart';
import 'package:health_care_app/patient_layout/presentation/screens/layout/patient_layout_screen.dart';
import 'package:health_care_app/patient_layout/presentation/screens/medicine/details_screen.dart';
import 'package:health_care_app/patient_layout/presentation/screens/medicine/sale_screen.dart';
import 'package:health_care_app/patient_layout/presentation/screens/payment/payment_details.dart';
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
    case MedicineDetailsScreen.routeName:
      Map<String, dynamic> arguments =
          settings.arguments as Map<String, dynamic>;
      final id = arguments['id'] as String;
      final name = arguments['name'] as String;
      final imageUrl = arguments['imageUrl'] as String;
      final description = arguments['description'] as String;
      final price = arguments['price'] as int;
      final quantity = arguments['quantity'] as int;
      return MaterialPageRoute(
        builder: (context) => MedicineDetailsScreen(
          medicine: {
            'id': id,
            'name': name,
            'description': description,
            'price': price,
            'imageUrl': imageUrl,
            'quantity': quantity
          },
        ),
      );
    case Sale_Screen.routeName:
      return MaterialPageRoute(
        builder: (context) => Sale_Screen(),
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
    case ChatScreen.routeName:
      Map<String, dynamic> arguments =
          settings.arguments as Map<String, dynamic>;
      final senderId = arguments['senderId'] as String;
      final receiverId = arguments['receiverId'] as String;
      final receiverType = arguments['receiverType'] as String;
      final senderType = arguments['senderType'] as String;
      return MaterialPageRoute(
        builder: (context) => ChatScreen(
          senderId: '$senderId',
          receiverId: '$receiverId',
          receiverType: '$receiverType',
          senderType: '$senderType',
        ),
      );
      case SupportScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SupportScreen(),
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
    
    case PatientSettingScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const PatientSettingScreen(),
      );
    case SettingDoctorScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SettingDoctorScreen(),
      );
    case WalletScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const WalletScreen(),
      );

    case PatientHomeScreen.routeName:
      return MaterialPageRoute(
        builder: (context) =>  PatientHomeScreen(),
      );
    case NotificationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const NotificationScreen(),
      );
    case PatientSettingScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const PatientSettingScreen(),
      );
    case PaymentDetailsScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const PaymentDetailsScreen(),
      );
    case PatientProfile.routeName:
      return MaterialPageRoute(builder: (context) => const PatientProfile());
    case ChangePasswordScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const ChangePasswordScreen());

    default:
      return MaterialPageRoute(
        builder: (context) => const PatientLayoutScreen(),
      );
  }
}
