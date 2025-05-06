import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:health_care_app/custom_widgets/customButton.dart';
import 'package:health_care_app/custom_widgets/customTextField.dart';

class CreatePassword extends StatelessWidget {
  static const routeName = 'create Password';
  const CreatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Create New Password',
            style: TextStyle(
                color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Enter your new password and confirm it..',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),
                CustomTextField(
                  text: 'Password',
                  icon: Icons.lock,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  text: 'Confirm Password',
                  icon: Icons.lock,
                ),
                const SizedBox(height: 150),
                CustomButton(
                  text: 'Submit',
                ),
              ],
            ),
          ),
        ));
  }
}
