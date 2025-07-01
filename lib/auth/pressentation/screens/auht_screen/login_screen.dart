import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_care_app/auth/data/services/auth_service.dart';
import 'package:health_care_app/auth/pressentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:health_care_app/auth/pressentation/screens/auht_screen/user_selection_screen.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/customButton.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/customTextField.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/custom_social_media.dart';
import 'package:health_care_app/doctor_layout/doctor_layout_screen.dart';
import 'package:health_care_app/patient_layout/patient_layout_screen.dart';

class LoginScreen extends StatefulWidget {
  final String? userType;
  static const routeName = 'login';
  const LoginScreen({
    super.key,
    required this.userType,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  late String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            log("User Type: ${widget.userType}");

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login successfully')),
            );

            if (widget.userType.toString() == 'doctor') {
              Navigator.pushNamed(context, DoctorLayoutScreen.routeName);
            } else if (widget.userType.toString() == 'patient') {
              Navigator.pushNamed(context, PatientLayoutScreen.routeName);
            }
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return state is AuthLoading
              ? const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          )
              : SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Column(
                children: [
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
                    padding:
                    const EdgeInsets.only(left: 240, top: 10, bottom: 10),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'forgotPassword');
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                  CustomButton(
                    onPressed: () async {
                      log(widget.userType.toString());
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('logged_in_email', email);

                        BlocProvider.of<AuthCubit>(context).login(
                          email,
                          password,
                          widget.userType!,
                        );
                      } else {
                        setState(() {
                          _autovalidateMode = AutovalidateMode.always;
                        });
                      }
                    },
                    text: 'Login',
                    padding: EdgeInsets.only(top: 50),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 20),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text(
                    'Login with',
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                  const SizedBox(height: 50),
                  CustomSocialMedia(),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            log(widget.userType.toString());
                            Navigator.pushNamed(
                              context,
                              'Signup',
                              arguments: widget.userType.toString(),
                            );
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}