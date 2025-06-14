import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/auth/pressentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/signup_user_body.dart';

class SignUpUserBodyBlocConsumer extends StatelessWidget {
  const SignUpUserBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('success')));
          Navigator.pushNamed(context, 'userSelection');
        } else if (state is SignupError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return state is SignupLoading
            ? const Center(child: CircularProgressIndicator())
            : const SignUpUserBody();
      },
    );
  }
}
