import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/auth/data/services/auth_service.dart';
import 'package:health_care_app/auth/pressentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/signUpDoctorBodyBlocConsumer.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/signUpDoctorBodyBlocConsumer.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/signUpUserBodyBlocConsumer.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/signup_doctor_body.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/signup_user_body.dart';
import 'package:health_care_app/doctor_layout/home_screen/home_screen.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/customButton.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/customTextField.dart';

class SignupScreen extends StatelessWidget {
  final String? userType;
  static const routeName = 'Signup';
  const SignupScreen({super.key, required this.userType});

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
        body: userType == 'doctor'
            ? SignUpDoctorBodyBlocConsumer()
            : SignUpUserBodyBlocConsumer(),
      );
  }
}
