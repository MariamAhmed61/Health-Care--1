import 'package:flutter/material.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/signup_doctor_body.dart';
import 'package:health_care_app/auth/pressentation/screens/doctor_layout/home_screen/home_screen.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/customButton.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/customTextField.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/custom_signup.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = 'Signup';
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign up',
          style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: DoctorSignUpBody(),
    );
  }
}
