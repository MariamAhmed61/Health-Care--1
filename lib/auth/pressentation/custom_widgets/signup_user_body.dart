import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/auth/pressentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/customButton.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/customTextField.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';

class SignUpUserBody extends StatefulWidget {
  const SignUpUserBody({
    super.key,
  });

  @override
  State<SignUpUserBody> createState() => _SignUpUserBodyState();
}

class _SignUpUserBodyState extends State<SignUpUserBody> {
  late String userType,
      firstName,
      lastName,
      email,
      password,
      confirmPassword,
      phoneNumber,
      address;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
         autovalidateMode: _autovalidateMode,
        child: Column(
          children: [
            CustomTextField(
              
              onSaved: (value) => firstName = value!,
              textInputType: TextInputType.name,
              text: 'first name',
              icon: Icons.person,
            ),
            CustomTextField(
              onSaved: (value) => lastName = value!,
              textInputType: TextInputType.name,
              text: 'last name',
              icon: Icons.person,
            ),
            CustomTextField(
              onSaved: (value) => email = value!,
              textInputType: TextInputType.emailAddress,
              text: 'email',
              icon: Icons.email,
            ),
            CustomTextField(
              onSaved: (value) => password = value!,
              text: 'password',
              icon: Icons.lock,
            ),
            CustomTextField(
              onSaved: (value) => confirmPassword = value!,
              text: 'confirm password',
              icon: Icons.lock,
            ),
            CustomTextField(
              onSaved: (value) => phoneNumber = value!,
              textInputType: TextInputType.phone,
              text: 'mobile number',
              icon: Icons.phone,
            ),
            CustomTextField(
              onSaved: (value) => address = value!,
              text: 'address',
              icon: Icons.location_on,
              textInputType: TextInputType.streetAddress,
            ),
            CustomButton(
              onPressed: ()async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  context.read<SignupCubit>().signup(
                      email: email,
                      firstName: firstName,
                      password: password,
                      lastName: lastName,
                      confirmPassword: confirmPassword,
                      phoneNumber: phoneNumber,
                      address: address,
                      userType: 'patient');
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
                        .pushReplacementNamed('login', arguments: 'patient');
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
