import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:health_care_app/patient_layout/data/models/doctor_response.dart';
import 'package:health_care_app/patient_layout/presentation/cubits/doctor_cubit/doctor_cubit.dart';
import 'package:health_care_app/patient_layout/presentation/cubits/doctor_cubit/doctor_state.dart';
import 'package:health_care_app/patient_layout/presentation/screens/doctor/doctor_profile.dart';
import 'package:health_care_app/patient_layout/presentation/screens/doctor/doctor_profile_screen.dart';


class SearchScreen extends StatelessWidget{
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Doctors',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  final state = context.read<DoctorCubit>().state;
                  if (state is DoctorLoaded) {
                    showSearch(
                      context: context,
                      delegate: MySearchDelegate(doctors: state.doctors),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Doctors not loaded yet')),
                    );
                  }
                },
                icon: const Icon(Icons.search_rounded),
              )
            ],
          ),
          body: BlocBuilder<DoctorCubit, DoctorState>(
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
                              builder: (_) => DoctorProfileScreen(doctorId: doctor.id!),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffE8E8E8),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: const CircleAvatar(
                                  radius: 30,
                                  child: Icon(
                                    Icons.person,
                                    color: AppColors.primaryColor,
                                    size: 35,
                                  ),
                                ),
                                title: Text(
                                  'Dr. ${doctor.firstName} ${doctor.lastName}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  doctor.specialization ?? '',
                                  style: const TextStyle(fontSize: 10),
                                ),
                                trailing: Text('\$ ${doctor.price ?? 0.0}'),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context).size.width * 0.2,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star_rounded,
                                      color: Color(0xffFFC700),
                                    ),
                                    Text(doctor.averageRating ?? '0.0'),
                                  ],
                                ),
                              ),
                            ],
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
    );
  }
}

class MySearchDelegate extends SearchDelegate<String> {
  final List<Doctor> doctors;
  MySearchDelegate({required this.doctors});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = doctors.where((doctor) {
      final fullName = '${doctor.firstName} ${doctor.lastName}'.toLowerCase();
      final specialization = doctor.specialization?.toLowerCase() ?? '';
      final searchLower = query.toLowerCase();
      return fullName.contains(searchLower) ||
          specialization.contains(searchLower);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final doctor = suggestions[index];
        return ListTile(
          leading: const CircleAvatar(
            radius: 30,
            child: Icon(
              Icons.person,
              color: AppColors.primaryColor,
              size: 35,
            ),
          ),
          title: Text('Dr. ${doctor.firstName} ${doctor.lastName}'),
          subtitle: Text(doctor.specialization ?? ''),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DoctorProfileScreen(doctorId: doctor.id!),
              ),
            );

          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? []
        : doctors.where((doctor) {
      final fullName =
      '${doctor.firstName} ${doctor.lastName}'.toLowerCase();
      final specialization = doctor.specialization?.toLowerCase() ?? '';
      final searchLower = query.toLowerCase();
      return fullName.contains(searchLower) ||
          specialization.contains(searchLower);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final doctor = suggestions[index];
        return ListTile(
          leading: const CircleAvatar(
            radius: 30,
            child: Icon(
              Icons.person,
              color: AppColors.primaryColor,
              size: 35,
            ),
          ),
          title: Text('Dr. ${doctor.firstName} ${doctor.lastName}'),
          subtitle: Text(doctor.specialization ?? ''),
          onTap: () {
            close(context, '');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DoctorProfileScreen(doctorId: doctor.id!),
              ),
            );

            showResults(context);
          },
        );
      },
    );
  }
}

