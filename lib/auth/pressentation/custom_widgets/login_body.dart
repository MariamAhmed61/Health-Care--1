import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/auth/pressentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/customButton.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/customTextField.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/custom_social_media.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';

class Login_body extends StatefulWidget {
  final String? userType;

  const Login_body({
    super.key,
    this.userType,
  });

  @override
  State<Login_body> createState() => _Login_bodyState();
}

class _Login_bodyState extends State<Login_body> {
  late String email;
  late String password;
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: Column(children: [
          CustomTextField(
            validator: (value) =>
                value!.isEmpty ? 'This field is required' : null,
            onSaved: (value) => email = value!,
            textInputType: TextInputType.emailAddress,
            text: 'Email',
            icon: Icons.email,
          ),
          CustomTextField(
            validator: (value) =>
                value!.isEmpty ? 'This field is required' : null,
            onSaved: (value) => password = value!,
            textInputType: TextInputType.visiblePassword,
            obsecureText: true,
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
            onPressed: () {
              log(widget.userType.toString());
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                BlocProvider.of<AuthCubit>(context)
                    .login(email, password, widget.userType.toString());
              } else {
                setState(() {
                  _autovalidateMode = AutovalidateMode.always;
                });
              }
            },
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
                      log(widget.userType.toString());
                      Navigator.pushNamed(context, 'Signup',
                          arguments: widget.userType.toString());
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
      ),
    );
  }
}
//  onPressed: () {
//                                     log(userType.toString());
//                                     Navigator.pushNamed(context, 'Signup',
//                                         arguments: userType.toString());
//                                   },