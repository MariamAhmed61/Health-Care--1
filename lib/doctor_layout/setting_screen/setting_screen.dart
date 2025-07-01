import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/doctor_layout/setting_screen/help_support_screen.dart';
import 'package:health_care_app/doctor_layout/setting_screen/show_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_care_app/auth/pressentation/screens/auht_screen/forgot_pass_screen.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:health_care_app/doctor_layout/setting_screen/change_password_screen.dart';
import 'package:health_care_app/doctor_layout/setting_screen/wallet_screen.dart';
import 'package:health_care_app/providers/setting_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:health_care_app/auth/pressentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:health_care_app/auth/pressentation/cubits/doctor_cubit/doctor_cubit.dart';
import 'package:provider/provider.dart';
import 'package:health_care_app/core/constants/app_assets/profile_image_widget.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = 'doctorsetting';
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isLoading = true;
  bool receiveNotifications = true;
  bool vibration = true;
  int? price;

  @override
  void initState() {
    super.initState();
    context.read<DoctorCubit>().getDoctorProfile();
    _loadNotificationSettings();
  }

  Future<void> _loadNotificationSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      receiveNotifications = prefs.getBool('receive_notifications') ?? true;
      vibration = prefs.getBool('vibration') ?? true;
      isLoading = false;
    });
  }

  Future<void> _saveSetting(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingProvider>(context);
    final lang = provider.language;
    final loc = AppLocalizations.of(context)!;

    final authState = context.watch<AuthCubit>().state;
    final doctorName = authState is AuthSuccess
        ? 'Dr ${authState.user?.firstName ?? ''} ${authState.user?.lastName ?? ''}'
        : 'Doctor Name';

    return SafeArea(
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : BlocBuilder<DoctorCubit, DoctorState>(
        builder: (context, docState) {
          if (docState is DoctorLoading) {
            return const Center(
              child: CircularProgressIndicator(
                  color: AppColors.primaryColor),
            );
          } else if (docState is DoctorLoaded) {
            var specialization = docState.doctor.specialization;
            var rating = docState.doctor.averageRating.toStringAsFixed(1);
            price = docState.doctor.price;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      loc.setting,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ProfileImage(
                        firstName: authState is AuthSuccess
                            ? authState.user?.firstName ?? ''
                            : '',
                        isEditable: true,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctorName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            specialization,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star_rounded, color: Color(0xffFFC700)),
                              const SizedBox(width: 10),
                              Text(
                                rating,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => ShowDialog.showEditPriceDialog(context: context,currentPrice: price!),
                    child: Row(
                      children: [
                        const Icon(Icons.attach_money, color: Colors.black),
                        const SizedBox(width: 10),
                        Text(
                          "${loc.examinationPrice}= $price ${loc.egp}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(WalletScreen.routeName);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.wallet),
                        const SizedBox(width: 10),
                        Text(loc.wallet,
                            style: const TextStyle(fontSize: 18, color: Colors.black)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.black),
                  const SizedBox(height: 10),
                  Text(loc.security,
                      style: const TextStyle(fontSize: 18, color: Colors.black)),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ChangePasswordScreen.routeName);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.lock),
                        const SizedBox(width: 10),
                        Text(loc.changePassword,
                            style: const TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ForgotPassword.routeName);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.lock_open),
                        const SizedBox(width: 10),
                        Text(loc.forgotPassword,
                            style: const TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.black),
                  const SizedBox(height: 10),
                  Text(loc.general,
                      style: const TextStyle(fontSize: 18, color: Colors.black)),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      ShowDialog.showNotificationDialog(
                        context: context,
                        receiveNotifications: receiveNotifications,
                        vibration: vibration,
                        onSave: (newReceive, newVibration) {
                          setState(() {
                            receiveNotifications = newReceive;
                            vibration = newVibration;
                          });
                          _saveSetting('receive_notifications', newReceive);
                          _saveSetting('vibration', newVibration);
                        },
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.notifications, color: Colors.black),
                        const SizedBox(width: 10),
                        Text(loc.notification, style: const TextStyle(color: Colors.black)),
                        const Spacer(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => ShowDialog.showLanguageDialog(context),
                    child: Row(
                      children: [
                        const Icon(Icons.language, color: Colors.black),
                        const SizedBox(width: 10),
                        Text(loc.language, style: const TextStyle(color: Colors.black)),
                        const Spacer(),
                        Text(
                          lang == 'en' ? 'English' : 'العربية',
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SupportScreen.routeName);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.help, color: Colors.black),
                        const SizedBox(width: 10),
                        Text(loc.helpSupport,
                            style: const TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.black),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      ShowDialog.showLogoutDialog(context);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.logout),
                        const SizedBox(width: 10),
                        Text(loc.logout),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}