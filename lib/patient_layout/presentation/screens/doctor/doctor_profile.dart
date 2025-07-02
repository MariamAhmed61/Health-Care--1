import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:health_care_app/auth/pressentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:health_care_app/generated/l10n.dart';
import 'package:health_care_app/patient_layout/presentation/cubits/doctor_details_cubit/doctor_details_cubit.dart';
import 'package:health_care_app/patient_layout/presentation/cubits/doctor_details_cubit/doctor_details_state.dart';
import 'package:health_care_app/patient_layout/presentation/screens/appointment/appointment_time.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorProfile extends StatefulWidget {
  final String id;

  const DoctorProfile({super.key, required this.id});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  bool isMapLoading = true;
  double selectedRating = 0;
  bool isRatingSubmitted = false;



  @override
  void initState() {
    super.initState();
    final cubit = context.read<DoctorDetailCubit>();
    if (cubit.state is! DoctorDetailLoaded) {
      cubit.fetchDoctor(widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorDetailCubit, DoctorDetailState>(
      builder: (context, state) {
        if (state is DoctorDetailLoading) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            body: const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            ),
          );
        } else if (state is DoctorDetailError) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            body: Center(child: Text(state.message)),
          );
        } else if (state is DoctorDetailLoaded) {
          final doctor = state.doctor;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Text(
                        S.of(context).doctor_profile,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            backgroundColor: AppColors.cyanColor,
                            radius: 33,
                            child: CircleAvatar(
                              radius: 30,
                              child: Icon(
                                Icons.person,
                                color: AppColors.primaryColor,
                                size: 35,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dr. ${doctor.firstName} ${doctor.lastName}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                doctor.specialization ??
                                    S.of(context).no_specialization,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.star_rounded,
                                      color: Color(0xffFFC700)),
                                  const SizedBox(width: 5),
                                  Text(
                                    doctor.averageRating ?? '0.0',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                color: const Color(0xffD9D9D9),
                                child: Text('\$ ${doctor.price}'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).doctor_details,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Icon(Icons.phone),
                              const SizedBox(width: 10),
                              Text(
                                doctor.phoneNumber ?? S.of(context).no_phone,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.mail),
                              const SizedBox(width: 10),
                              Text(
                                doctor.email ?? S.of(context).no_email,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.location_pin),
                              const SizedBox(width: 10),
                              Text(
                                doctor.address ?? S.of(context).no_address,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          if (state.latitude != null && state.longitude != null)
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  height: 200,
                                  child: GoogleMap(
                                    onTap: (LatLng latLng) => _openGPS(
                                        latLng.latitude, latLng.longitude),
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                          state.latitude!, state.longitude!),
                                      zoom: 14,
                                    ),
                                    markers: {
                                      Marker(
                                        markerId:
                                            const MarkerId("doctor_location"),
                                        position: LatLng(
                                            state.latitude!, state.longitude!),
                                        infoWindow: InfoWindow(
                                          title: "Dr. ${doctor.firstName}",
                                          snippet: doctor.address,
                                        ),
                                      ),
                                    },
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      setState(() {
                                        isMapLoading = false;
                                      });
                                    },
                                    zoomControlsEnabled: false,
                                  ),
                                ),
                                if (isMapLoading)
                                  const Positioned.fill(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                              ],
                            )
                          else
                            const Center(child: Text("Location not available")),

                          const SizedBox(height: 20),
                          const Text(
                            'Rate and Review this Doctor:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: RatingBar(
                              initialRating: selectedRating,
                              filledIcon: Icons.star,
                              emptyIcon: Icons.star_border,
                              halfFilledIcon: Icons.star_half,
                              isHalfAllowed: true,
                              filledColor: Colors.amber,
                              emptyColor: Colors.grey,
                              size: 30, onRatingChanged:(rating) {
                                setState(() {
                                  selectedRating = rating;
                                  isRatingSubmitted = false;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: isRatingSubmitted
                                ? null
                                : () => _submitRating(context, doctor.id!),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              isRatingSubmitted ? 'Thank You!' : 'Submit Review',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (isRatingSubmitted)
                            const Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                'Your rate has been submitted!',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) {
                                    final authState = context.read<AuthCubit>().state;
                                    String patientId = '';
                                    if (authState is AuthSuccess) {
                                      patientId = authState.user.id ?? '';
                                    }
                                    return AppointmentTime(
                                      doctor: doctor,
                                    );
                                  },
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: const BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Text(
                                S.of(context).book_appointment,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Future<void> _submitRating(BuildContext context, String doctorId) async {
    try {
      final authState = context.read<AuthCubit>().state;
      String userId = '';
      if (authState is AuthSuccess) {
        userId = authState.user.id ?? '';
      }

      context.read<DoctorDetailCubit>().rateDoctor(
        doctorId: doctorId,
        rating: selectedRating.toInt(),
        userId: userId,
      );

      setState(() {
        isRatingSubmitted = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thank you for your rating!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit rate: ${e.toString()}')),
      );
    }
  }

  void _openGPS(double lat, double lng) async {
    final Uri url = Uri.parse("google.navigation:q=$lat,$lng");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("GPS app not found")),
      );
    }
  }
}