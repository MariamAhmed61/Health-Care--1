import 'package:flutter/material.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/customButton.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/customTextField.dart';
import 'package:health_care_app/doctor_layout/home_screen/home_screen.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';

class DoctorSignUpBody extends StatelessWidget {
  const DoctorSignUpBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomTextField(
          
          textInputType: TextInputType.name,
          text: 'first name',
          icon: Icons.person,
        ),
        CustomTextField(
          textInputType: TextInputType.name,
          text: 'last name',
          icon: Icons.person,
        ),
        CustomTextField(
          textInputType: TextInputType.emailAddress,
          text: 'email',
          icon: Icons.email,
        ),
        CustomTextField(
          text: 'password',
          icon: Icons.lock,
        ),
        CustomTextField(
          text: 'confirm password',
          icon: Icons.lock,
        ),
        CustomTextField(
          textInputType: TextInputType.phone,
          text: 'mobile number',
          icon: Icons.phone,
        ),
        CustomTextField(
          text: 'address',
          icon: Icons.location_on,
          textInputType: TextInputType.streetAddress,
        ),
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
                  Navigator.of(context)
                      .pushReplacementNamed('login', arguments: 'doctor');
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
    );
  }
}
