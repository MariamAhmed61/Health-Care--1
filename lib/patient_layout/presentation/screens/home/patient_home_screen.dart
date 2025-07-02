import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/auth/pressentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:health_care_app/chat/presentation/screens/chat_icon_button.dart';
import 'package:health_care_app/chat/presentation/screens/chat_screen.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:health_care_app/generated/l10n.dart';
import 'package:health_care_app/patient_layout/presentation/cubits/appointment_cubit/appointment_cubit.dart';
import 'package:health_care_app/patient_layout/presentation/cubits/appointment_cubit/appointment_state.dart';
import 'package:health_care_app/patient_layout/presentation/screens/doctor/doctor_profile_screen.dart';
import 'package:health_care_app/patient_layout/presentation/screens/doctor/search_screen.dart';

import '../../cubits/doctor_cubit/doctor_cubit.dart';
import '../../cubits/doctor_cubit/doctor_state.dart';

class PatientHomeScreen extends StatefulWidget {
  static const routeName = 'patient-home';

  PatientHomeScreen({
    super.key,
  });

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  DateTime selectedDate = DateTime.now();

@override
 void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_) {
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthSuccess) {
      context.read<AppointmentCubit>().fetchPatientAppointments(authState.user.id!);
    }
    }
     );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.primaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
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
                          initialDate: selectedDate,
                          activeColor: AppColors.primaryColor,
                          onDateChange: (date) {
                            selectedDate = date;

                            final authState = context.read<AuthCubit>().state;
                            if (authState is AuthSuccess) {
                              context
                                  .read<AppointmentCubit>()
                                  .fetchPatientAppointments(authState.user.id!);
                            }
                          },
                        ),
                        Expanded(child:
                            BlocBuilder<AppointmentCubit, AppointmentState>(
                          builder: (context, appointmentState) {
                            if (appointmentState is AppointmentLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (appointmentState
                                is PatientAppointmentsLoaded) {
                              final selectedDateStr = selectedDate
                                  .toIso8601String()
                                  .split('T')
                                  .first;

                              final todayAppointments =
                                  appointmentState.appointments.where(
                                (a) => a['date'] == selectedDateStr,
                              );

                              final bookedDoctorIds = todayAppointments
                                  .map((a) => a['doctorId'])
                                  .toSet();

                              final doctorState =
                                  context.read<DoctorCubit>().state;
                              if (doctorState is DoctorLoaded) {
                                final allDoctors = doctorState.doctors;

                                final bookedDoctors = allDoctors
                                    .where((doc) =>
                                        bookedDoctorIds.contains(doc.id))
                                    .toList();

                                if (bookedDoctors.isEmpty) {
                                  return const Center(
                                      child: Text("لا يوجد حجوزات لهذا اليوم"));
                                }

                                return ListView.builder(
                                  itemCount: bookedDoctors.length,
                                  itemBuilder: (context, index) {
                                    final doctor = bookedDoctors[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  DoctorProfileScreen(
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
                                              child: Icon(Icons.person,
                                                  color: AppColors.primaryColor,
                                                  size: 35),
                                            ),
                                            title: Text(
                                              'Dr. ${doctor.firstName} ${doctor.lastName}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text(
                                                doctor.specialization ?? ''),
                                            trailing: ChatIconButton(
                                                doctorId: doctor.id!),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                    child: Text("جاري تحميل الأطباء..."));
                              }
                            } else if (appointmentState is AppointmentError) {
                              return Center(
                                  child: Text(appointmentState.message));
                            }
                            return const SizedBox.shrink();
                          },
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocBuilder<AuthCubit, AuthStates>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is AuthSuccess) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).welcome_message,
                              style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${state.user.firstName} ${state.user.lastName}',
                              style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      } else if (state is AuthError) {
                        return Text(
                          state.message,
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                const Spacer(),
                const CircleAvatar(
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
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      S.of(context).lets_find_doctor,
                      style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SearchScreen(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            child: Row(
                              children: [
                                Text(
                                  S.of(context).search,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                const Spacer(),
                                const Icon(
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
