import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:health_care_app/auth/pressentation/screens/auht_screen/user_selection_screen.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/customButton.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/customTextField.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/custom_social_media.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
    required this.userType,
  });
  final String? userType;
  static const routeName = 'login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Login',
            style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            CustomTextField(
              textInputType: TextInputType.emailAddress,
              text: 'Email',
              icon: Icons.email,
            ),
            CustomTextField(
              text: 'Password',
              icon: Icons.lock,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 240, top: 10, bottom: 10),
              child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'forgotPassword');
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: AppColors.primaryColor),
                  )),
            ),
            CustomButton(
              text: 'Login',
              padding: EdgeInsets.only(
                top: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                bottom: 20,
              ),
              child: Text(
                'OR',
                style: TextStyle(color: AppColors.primaryColor, fontSize: 20),
              ),
            ),
            Text('Login with', style: TextStyle(color: AppColors.primaryColor)),
            const SizedBox(height: 50),
            CustomSocialMedia(),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dont have an account?',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  TextButton(
                      onPressed: () {
                        log(userType.toString());
                        Navigator.pushNamed(context, 'Signup' ,arguments: userType.toString());
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            )
          ]),
        ));
  }
}
