import 'package:flutter/material.dart';
import 'package:health_care_app/auth/pressentation/screens/doctor_layout/doctor_layout_screen.dart';
import 'package:health_care_app/auth/pressentation/screens/doctor_layout/home_screen/home_screen.dart';
import 'package:health_care_app/core/helper/on_generate_routs.dart';
import 'package:health_care_app/splash/splash_screen.dart';


void main() {
  runApp(const HealthCare());
}

class HealthCare extends StatelessWidget {
  const HealthCare({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      initialRoute: DoctorLayoutScreen.routeName,
    );
  }
}
