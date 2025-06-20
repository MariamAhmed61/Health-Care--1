
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:health_care_app/patient_layout/presentation/screens/doctor/doctor_profile_screen.dart';
import 'package:health_care_app/patient_layout/presentation/screens/doctor/search_screen.dart';

import '../../cubits/doctor_cubit/doctor_cubit.dart';
import '../../cubits/doctor_cubit/doctor_state.dart';


class PatientHomeScreen extends StatelessWidget {
  static const routeName = 'patient-home';

  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      DoctorCubit()
        ..fetchDoctors(),
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      EasyDateTimeLine(
                        initialDate: DateTime.now(),
                        activeColor: AppColors.primaryColor,
                      ),
                      Expanded(
                        child: BlocBuilder<DoctorCubit, DoctorState>(
                          builder: (context, state) {
                            if (state is DoctorLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                              );
                            } else if (state is DoctorError) {
                              return Center(child: Text(state.message));
                            } else if (state is DoctorLoaded) {
                              final doctorsList = state.doctors;
                              return ListView.builder(
                                itemCount: doctorsList.length,
                                itemBuilder: (context, index) {
                                  final doctor = doctorsList[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => DoctorProfileScreen(
                                                doctorId: doctor.id!),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xffE8E8E8),
                                          borderRadius:
                                          BorderRadius.circular(16),
                                        ),
                                        child: ListTile(
                                          leading: const CircleAvatar(
                                            radius: 30,
                                            child: Icon(
                                              Icons.person,
                                              color: AppColors.primaryColor,
                                              size: 35,
                                            ),
                                          ),
                                          title: Text(
                                            'Dr. ${doctor.firstName} ${doctor
                                                .lastName}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            doctor.specialization ?? '',
                                            style:
                                            const TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cyanColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good Morning!',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'userName',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                ),
                  
                Spacer(),
                CircleAvatar(
                  radius: 30,
                  child: Icon(
                    Icons.person,
                    color: AppColors.primaryColor,
                    size: 35,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      'Let\'s Find Your Specialist',
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                            const SearchScreen(),
                          ),
                        );
                        }
                      ,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            child: Row(
                              children: [
                                Text(
                                  'Search...',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.search,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
