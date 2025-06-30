
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/patient_layout/presentation/screens/doctor/doctor_profile.dart';
import '../../cubits/doctor_details_cubit/doctor_details_cubit.dart';


class DoctorProfileScreen extends StatelessWidget {
  final String doctorId;

  const DoctorProfileScreen({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DoctorDetailCubit()..fetchDoctor(doctorId),
      child: DoctorProfile(id: doctorId),
    );
  }
}
