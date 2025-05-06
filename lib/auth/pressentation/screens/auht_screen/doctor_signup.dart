import 'package:flutter/material.dart';
import 'package:health_care_app/auth/pressentation/screens/doctor_layout/home_screen/home_screen.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:health_care_app/custom_widgets/customButton.dart';
import 'package:health_care_app/custom_widgets/customTextField.dart';
import 'package:health_care_app/custom_widgets/custom_signup.dart';

class DoctorSignup extends StatelessWidget {
  static const routeName = 'doctorSignup';
  const DoctorSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign up',
          style: TextStyle(
              color: AppColors.primaryColor, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomSignUp(),
            CustomTextField(text: 'Specialization', icon: Icons.shopping_bag),
            CustomButton(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              text: 'Signup',
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Already have an account?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(DoctorHomeScreen.routeName);

                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ))
            ])
          ],
        ),
      ),
    );
  }
}
