
import 'package:flutter/material.dart';
import 'package:health_care_app/custom_widgets/customButton.dart';
import 'package:health_care_app/custom_widgets/splash_logo.dart';

class UserSelection extends StatelessWidget {
  const UserSelection({super.key});
  static const routeName = 'userSelection';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const SplashLogo(),
            const SizedBox(height: 150),
           const Text('choose your role :', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 50),
            CustomButton(
              onPressed: () => Navigator.pushNamed(context, 'login'),
              text: 'Doctor',
            ),
            CustomButton(
              onPressed: () => Navigator.pushNamed(context, 'login'),
              text: 'Patient',
            ),
          ],
        ),
      ),
    );
  }
}
