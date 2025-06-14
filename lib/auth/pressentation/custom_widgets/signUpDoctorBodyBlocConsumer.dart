import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/auth/pressentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/signup_doctor_body.dart';

class SignUpDoctorBodyBlocConsumer extends StatelessWidget {
  const SignUpDoctorBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return const DoctorSignUpBody();
      },
    );
  }
}
