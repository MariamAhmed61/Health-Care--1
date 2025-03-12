import 'package:flutter/material.dart';
import 'package:health_care_app/constant.dart';
import 'package:health_care_app/custom_widgets/customButton.dart';
import 'package:health_care_app/custom_widgets/customTextField.dart';

class ForgotPassword extends StatelessWidget {
  static const routeName = 'forgotPassword';
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          style: TextStyle(
              color: primaryColor, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(children: [
            Text(
              'Enter your mobile number to receive a verification code..',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            CustomTextField(
              text: 'Mobile Number',
              icon: Icons.phone,
            ),
            const SizedBox(height: 150),
            CustomButton(
              text: 'Submit',
            ),
          ]),
        ),
      ),
    );
  }
}
