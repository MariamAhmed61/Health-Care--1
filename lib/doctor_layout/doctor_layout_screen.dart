import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:health_care_app/doctor_layout/home_screen/home_screen.dart';
import 'package:health_care_app/doctor_layout/notification_screen/notification_screen.dart';
import 'package:health_care_app/doctor_layout/setting_screen/setting_screen.dart';
import 'package:health_care_app/doctor_layout/avaliable_slots_screen/available_solts_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DoctorLayoutScreen extends StatefulWidget {
  static const routeName = 'doctorlayout';

  const DoctorLayoutScreen({super.key});

  @override
  State<DoctorLayoutScreen> createState() => _DoctorLayoutScreenState();
}

class _DoctorLayoutScreenState extends State<DoctorLayoutScreen> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    DoctorHomeScreen(),
    NotificationScreen(),
    AvailableSlotsScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BottomNavigationBar(
            backgroundColor: AppColors.white,
            fixedColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                label: AppLocalizations.of(context)!.home,
                icon: Icon(
                  Icons.home_outlined,
                  color: selectedIndex == 0
                      ? AppColors.primaryColor
                      : Colors.black,
                ),
              ),
              BottomNavigationBarItem(
                label: AppLocalizations.of(context)!.notification,
                icon: Icon(
                  Icons.notifications_none,
                  color: selectedIndex == 1
                      ? AppColors.primaryColor
                      : Colors.black,
                ),
              ),
              BottomNavigationBarItem(
                label: AppLocalizations.of(context)!.available,
                icon: Icon(
                  Icons.calendar_today_outlined,
                  color: selectedIndex == 2
                      ? AppColors.primaryColor
                      : Colors.black,
                ),
              ),
              BottomNavigationBarItem(
                label: AppLocalizations.of(context)!.setting,
                icon: Icon(
                  Icons.settings,
                  color: selectedIndex == 3
                      ? AppColors.primaryColor
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: screens[selectedIndex],
    );
  }
}