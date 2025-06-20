import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/auth/data/services/auth_service.dart';
import 'package:health_care_app/auth/pressentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:health_care_app/core/helper/on_generate_routs.dart';
import 'package:health_care_app/patient_layout/presentation/cubits/doctor_cubit/doctor_cubit.dart';
import 'package:health_care_app/splash/views/splash_screen.dart';

void main() {
  runApp(const HealthCare());
}

class HealthCare extends StatelessWidget {
  const HealthCare({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DoctorCubit()..fetchDoctors()),
        BlocProvider(create: (context)=>AuthCubit(AuthService()))
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: onGenerateRoute,
          initialRoute: SplashScreen.routeName,
          ),
    );
  }
}
