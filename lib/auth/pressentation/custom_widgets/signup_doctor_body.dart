import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/auth/pressentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/customButton.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/customTextField.dart';
import 'package:health_care_app/doctor_layout/home_screen/home_screen.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';

class DoctorSignUpBody extends StatefulWidget {
  const DoctorSignUpBody({
    super.key,
  });

  @override
  State<DoctorSignUpBody> createState() => _DoctorSignUpBodyState();
}

class _DoctorSignUpBodyState extends State<DoctorSignUpBody> {
  late String firstName,
      lastName,
      email,
      password,
      confirmPassword,
      phoneNumber,
      address,
      specialization,
      userType;
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: Column(
          children: [
            CustomTextField(
              validator: (value) =>
                  value!.isEmpty ? 'This field is required' : null,
              onSaved: (value) => firstName = value!,
              textInputType: TextInputType.name,
              text: 'first name',
              icon: Icons.person,
            ),
            CustomTextField(
              validator: (value) =>
                  value!.isEmpty ? 'This field is required' : null,
              onSaved: (value) => lastName = value!,
              textInputType: TextInputType.name,
              text: 'last name',
              icon: Icons.person,
            ),
            CustomTextField(
              validator: (value) =>
                  value!.isEmpty ? 'This field is required' : null,
              onSaved: (value) => email = value!,
              textInputType: TextInputType.emailAddress,
              text: 'email',
              icon: Icons.email,
            ),
            CustomTextField(
              onSaved: (value) => password = value!,
              text: 'Password',
              icon: Icons.lock,
              obsecureText: true,
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Required';
                return null;
              },
            ),
            CustomTextField(
              onSaved: (value) => confirmPassword = value!,
              text: 'Confirm Password',
              icon: Icons.lock,
              obsecureText: true,
              controller: confirmPasswordController,
              validator: (value) {
                if (value != passwordController.text)
                  return 'Passwords do not match';
                return null;
              },
            ),
            CustomTextField(
              validator: (value) =>
                  value!.isEmpty ? 'This field is required' : null,
              onSaved: (value) => phoneNumber = value!,
              textInputType: TextInputType.phone,
              text: 'mobile number',
              icon: Icons.phone,
            ),
            CustomTextField(
              validator: (value) =>
                  value!.isEmpty ? 'This field is required' : null,
              onSaved: (value) => address = value!,
              text: 'address',
              icon: Icons.location_on,
              textInputType: TextInputType.streetAddress,
            ),
            CustomTextField(
              validator: (value) =>
                  value!.isEmpty ? 'This field is required' : null,
              text: 'Specialization',
              icon: Icons.shopping_bag,
              onSaved: (value) => specialization = value!,
            ),
            CustomButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  BlocProvider.of<AuthCubit>(context).signup(
                      email: email,
                      specialization: specialization,
                      password: password,
                      firstName: firstName,
                      lastName: lastName,
                      confirmPassword: confirmPassword,
                      phoneNumber: phoneNumber,
                      address: address,
                      userType: 'doctor');
                } else {
                  setState(() {
                    _autovalidateMode = AutovalidateMode.always;
                  });
                }
              },
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
      ),
    );
  }
}
