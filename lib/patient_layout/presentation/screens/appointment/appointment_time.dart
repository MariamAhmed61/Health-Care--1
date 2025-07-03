import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:health_care_app/generated/l10n.dart';
import 'package:health_care_app/patient_layout/data/models/doctor_response.dart';
import 'package:health_care_app/auth/pressentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:health_care_app/patient_layout/presentation/cubits/appointment_cubit/appointment_cubit.dart';
import 'package:health_care_app/patient_layout/presentation/cubits/appointment_cubit/appointment_state.dart';
import 'package:health_care_app/patient_layout/presentation/screens/payment/payment_details.dart';

class AppointmentTime extends StatefulWidget {
  final Doctor doctor;
  const AppointmentTime({super.key, required this.doctor});

  @override
  State<AppointmentTime> createState() => _AppointmentTimeState();
}

class _AppointmentTimeState extends State<AppointmentTime> {
  DateTime selectedDate = DateTime.now();
  String selectedTime = '';
  List<String> availableTimes = [];
  String paymentMethod = 'cash';

  @override
  void initState() {
    super.initState();
    _updateAvailableTimes();
  }

  void _updateAvailableTimes() {
    final today = selectedDate.toIso8601String().split('T').first;
    final slot = widget.doctor.availableSlots?.firstWhere(
      (s) => s.date == today,
      orElse: () => AvailableSlot(date: today, times: []),
    );

    setState(() {
      availableTimes = slot?.times ?? [];
      selectedTime = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentPatientCubit, AppointmentState>(
      listener: (context, state) {
        if (state is AppointmentLoaded) {
          _showDialog(context, state.message);
        } else if (state is AppointmentError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
              title: Text(
                S.of(context).doctor_details,
                style: const TextStyle(color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: state is AppointmentLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 33,
                              child: Icon(Icons.person,
                                  color: AppColors.primaryColor, size: 35),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Dr. ${widget.doctor.firstName} ${widget.doctor.lastName}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    widget.doctor.specialization ??
                                        S.of(context).no_specialization,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      EasyDateTimeLine(
                        initialDate: selectedDate,
                        activeColor: AppColors.primaryColor,
                        onDateChange: (date) {
                          setState(() {
                            selectedDate = date;
                            selectedTime = '';
                          });
                          _updateAvailableTimes();
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Available Times",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: availableTimes.isEmpty
                            ? const Center(
                                child: Text(
                                  "No available times",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            : GridView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: availableTimes.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1.6,
                                ),
                                itemBuilder: (context, index) {
                                  final time = availableTimes[index];
                                  final isSelected = time == selectedTime;

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedTime = time;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: isSelected
                                            ? AppColors.primaryColor
                                            : const Color(0xffD9D9D9),
                                      ),
                                      child: Center(
                                        child: Text(
                                          time,
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Container(
                           decoration: BoxDecoration(
                             color: const Color(0xffD9D9D9),
                             borderRadius: BorderRadius.circular(8),
                           ),
                           child: Row(
                             children: [
                               Padding(
                                 padding: const EdgeInsets.all(32.0),
                                 child: Center(
                                   child: Text(
                                     S.of(context).payment_method,
                                     style: const TextStyle(
                                         color: AppColors.primaryColor,
                                         fontWeight: FontWeight.bold),
                                   ),
                                 ),
                               ),
                               TextButton(
                                 onPressed: () {
                                  paymentMethod ='cash';
                                  setState(() {
                                    
                                  });
                                 },
                                 child: Text(
                                   S.of(context).cash,
                                   style: const TextStyle(
                                       color: Colors.green,
                                       fontWeight: FontWeight.bold),
                                 ),
                               ),
                               TextButton(
                                 onPressed: () {
                                   Navigator.pushNamed(
                                       context, PaymentDetailsScreen.routeName);
                                 },
                                 child: Text(
                                   S.of(context).visa,
                                   style: const TextStyle(
                                       color: Color.fromARGB(255, 175, 76, 142),
                                       fontWeight: FontWeight.bold),
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ),
                      Center(
                        child: ElevatedButton(
                          onPressed: selectedTime.isEmpty
                              ? null
                              : () {
                                  final authState =
                                      context.read<AuthCubit>().state;
                                  String patientId = '';
                                  if (authState is AuthSuccess) {
                                    patientId = authState.user?.id ?? '';
                                  }

                                  context
                                      .read<AppointmentPatientCubit>()
                                      .bookAppointment(
                                        doctorId: widget.doctor.id!,
                                        patientId: patientId,
                                        date: selectedDate
                                            .toIso8601String()
                                            .split('T')
                                            .first,
                                        time: selectedTime,
                                          paymentMethod: paymentMethod,
                                      );
                                },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.2,
                            ),
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(
                                color: AppColors.white,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Text(
                            S.of(context).done,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
          ),
        );
      },
    );
  }

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              backgroundColor: AppColors.cyanColor,
              radius: 30,
              child: Icon(Icons.check, color: Colors.black, size: 30),
            ),
            const SizedBox(height: 10),
            Text(
              S.of(context).booking_successful,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              message,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
