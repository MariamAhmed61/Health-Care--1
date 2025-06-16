import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/auth/pressentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/signup_user_body.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';

class SignUpUserBodyBlocConsumer extends StatelessWidget {
  const SignUpUserBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('sign up successfully')));
          Navigator.pop(context);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return state is AuthLoading
            ? const Center(child: CircularProgressIndicator( color:  AppColors.primaryColor,))
            : const SignUpUserBody();
      },
    );
  }
}
