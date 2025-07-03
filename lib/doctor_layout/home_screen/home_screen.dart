import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:health_care_app/auth/pressentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:health_care_app/chat/data/message_service.dart';
import 'package:health_care_app/chat/presentation/cubit/message_cubit.dart';
import 'package:health_care_app/chat/presentation/screens/chat_screen.dart';
import 'package:health_care_app/core/constants/app_assets/profile_image_widget.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:health_care_app/auth/data/models/appointment_with_patient_model.dart';
import 'package:health_care_app/auth/pressentation/cubits/appointment_cubit/appointment_cubit.dart';
import 'package:health_care_app/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});
  static const routeName = 'doctorhome';

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<AppointmentWithPatientModel> filteredAppointments = [];

  @override
  void initState() {
    super.initState();
    context.read<AppointmentCubit>().fetchAppointmentsWithPatient();
    _searchController.addListener(_filterAppointments);
  }

  void _filterAppointments() {
    final query = _searchController.text.toLowerCase();
    final cubit = context.read<AppointmentCubit>();
    final appointments = cubit.state is AppointmentLoaded
        ? (cubit.state as AppointmentLoaded).appointments
        : <AppointmentWithPatientModel>[];

    setState(() {
      filteredAppointments = appointments
          .where((appt) => appt.date.toLowerCase().contains(query))
          .toList();
    });
  }

  void _makePhoneCall(String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    final doctorName =
        authState is AuthSuccess ? authState.user?.firstName ?? '' : 'Doctor';

    return SafeArea(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      ProfileImage(
                        firstName: authState is AuthSuccess
                            ? authState.user?.firstName ?? ''
                            : '',
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        '${S.of(context).welcomeDoctor}$doctorName',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        S.of(context).haveANiceDay,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: S.of(context).searchByDate,
                          border: InputBorder.none,
                          suffixIcon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),

          // Title
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  S.of(context).upcomingAppointments,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Appointments
          Expanded(
            child: BlocBuilder<AppointmentCubit, AppointmentState>(
              builder: (context, state) {
                if (state is AppointmentLoading) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ));
                } else if (state is AppointmentLoaded) {
                  final allAppointments = state.appointments;
                  final isSearching = _searchController.text.isNotEmpty;
                  final appointments =
                      isSearching ? filteredAppointments : allAppointments;

                  if (appointments.isEmpty) {
                    return Center(
                      child: Text(
                        isSearching
                            ? S.of(context).bookSearch
                            : S.of(context).noAppointmentsFound,
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: appointments.length,
                    itemBuilder: (context, index) {
                      final appt = appointments[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.white,
                              child: Text(
                                appt.patient.firstName.isNotEmpty
                                    ? appt.patient.firstName[0]
                                    : '?',
                                style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(
                              '${appt.patient.firstName} ${appt.patient.lastName}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text(
                              '${appt.date} - ${appt.time}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.call,
                                      color: Colors.white),
                                  onPressed: () =>
                                      _makePhoneCall(appt.patient.phoneNumber),
                                ),
                                IconPatientButtonChat(
                                  patientId: appt.patient.id,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is AppointmentError) {
                  return Center(child: Text(state.message));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class IconPatientButtonChat extends StatelessWidget {
  final String patientId;
  const IconPatientButtonChat({
    super.key,
    required this.patientId,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.chat, color: Colors.white),
        onPressed: () {
          final authState = context.read<AuthCubit>().state;

          if (authState is AuthSuccess) {
            final senderId = authState.user?.id;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => MessageCubit(MessageService()),
                  child: ChatScreen(
                    senderId: senderId as String,
                    receiverId: patientId,
                    senderType: 'Doctor',
                    receiverType: 'Patient',
                  ),
                ),
              ),
            );
          }
        });
  }
}
