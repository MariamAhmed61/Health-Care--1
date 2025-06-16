import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/auth/pressentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/customButton.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/customTextField.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/custom_social_media.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/login_body.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';

class LoginBlocConsumerBody extends StatelessWidget {
  static const routeName = 'login';
  const LoginBlocConsumerBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Login successfully')));
          if (state.userType == 'patient') {
            Navigator.pushNamed(context, 'patientLayout');
          } else if (state.userType == 'doctor') {
            Navigator.pushNamed(context, 'doctorLayout');
          }
          Navigator.pushNamed(context, 'userSelection');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return state is AuthLoading
            ? const Center(child: CircularProgressIndicator())
            : Login_body();
      },
    );
  }
}
