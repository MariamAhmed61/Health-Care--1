import 'package:flutter/material.dart';
import 'package:health_care_app/custom_widgets/customTextField.dart';

class CustomSignUp extends StatelessWidget {
  const CustomSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}
