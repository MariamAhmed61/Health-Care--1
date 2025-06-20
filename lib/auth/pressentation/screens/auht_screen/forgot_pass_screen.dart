import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/auth/data/services/auth_service.dart';
import 'package:health_care_app/auth/pressentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/customButton.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/customTextField.dart';

class ForgotPassword extends StatefulWidget {
  final String? userType;

  static const routeName = 'forgotPassword';
  const ForgotPassword({super.key, required this.userType});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  late String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthService()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Forgot Password',
            style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: SingleChildScrollView(
            child: BlocConsumer<AuthCubit, AuthStates>(
              builder: (context, state) {
                return Form(
                  key: formKey,
                  autovalidateMode: _autovalidateMode,
                  child: Column(children: [
                    Text(
                      'Enter your mobile number to receive a verification code..',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 60),
                    CustomTextField(
                      validator: (value) =>
                          value!.isEmpty ? 'This field is required' : null,
                      textInputType: TextInputType.phone,
                      onSaved: (value) {
                        phoneNumber = value!;
                      },
                      text: 'Mobile Number',
                      icon: Icons.phone,
                    ),
                    const SizedBox(height: 150),
                    CustomButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          BlocProvider.of<AuthCubit>(context)
                              .sendCode(phoneNumber, widget.userType!);
                        } else {
                          setState(() {
                            _autovalidateMode = AutovalidateMode.always;
                          });
                        }
                      },
                      text: 'Submit',
                    ),
                  ]),
                );
              },
              listener: (BuildContext context, AuthStates state) {
                if (state is AuthError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                } else if (state is AuthCodeSent) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.code)));
                  Navigator.pushNamed(context, 'verifyNumber');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
