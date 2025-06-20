import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/auth/data/services/auth_service.dart';
import 'package:health_care_app/auth/pressentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:health_care_app/auth/pressentation/screens/auht_screen/login_screen.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/customButton.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/customTextField.dart';

class CreatePassword extends StatefulWidget {
  final String? phoneNumber;
  final String? code;
  final String? userType;
  static const routeName = 'createPassword';
  const CreatePassword({super.key, this.phoneNumber, this.userType, this.code});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  late String password;
  late String confirmPassword;
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthService()),
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Create New Password',
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          body: BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('password changed')));
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen(
                              userType: widget.userType,
                            )));
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              return state is AuthLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ))
                  : Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 20, right: 20),
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          autovalidateMode: _autovalidateMode,
                          child: Column(
                            children: [
                              Text(
                                'Enter your new password and confirm it..',
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 60),
                              CustomTextField(
                                onSaved: (value) => password = value!,
                                text: 'Password',
                                icon: Icons.lock,
                                obsecureText: true,
                                controller: passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty)
                                    return 'Required';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
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
                              const SizedBox(height: 60),
                              CustomButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      BlocProvider.of<AuthCubit>(context)
                                          .resetPassword(
                                              confirmPasswordController.text,
                                              widget.phoneNumber.toString(),
                                              widget.userType.toString(),
                                              widget.code.toString());
                                      log('phoneNumber: ${widget.phoneNumber.toString()}');
                                      log('userType: ${widget.userType.toString()}');
                                      log('code: ${widget.code.toString()}');
                                    } else {
                                      setState(() {
                                        _autovalidateMode =
                                            AutovalidateMode.always;
                                      });
                                    }
                                  },
                                  text: 'Create Password'),
                            ],
                          ),
                        ),
                      ),
                    );
            },
          )),
    );
  }
}
