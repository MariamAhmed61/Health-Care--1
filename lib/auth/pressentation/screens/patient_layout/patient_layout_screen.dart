import 'package:flutter/material.dart';
import 'package:health_care_app/auth/pressentation/screens/patient_layout/patient_home_screen/patient_home_screen.dart';
import 'package:health_care_app/auth/pressentation/screens/patient_layout/patient_notification_screen/patient_notification_screen.dart';
import 'package:health_care_app/auth/pressentation/screens/patient_layout/patient_setting_screen/patient_setting_screen.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';

class PatientLayoutScreen extends StatefulWidget {
  const PatientLayoutScreen({super.key});

  @override
  State<PatientLayoutScreen> createState() => _PatientLayoutScreenState();
}

class _PatientLayoutScreenState extends State<PatientLayoutScreen> {
  int selectedIndex = 0;
  List<Widget> screens = [
    PatientHomeScreen(),
    PatientNotificationScreen(),
    PatientSettingScreen(),

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

              onTap: (value) {
                selectedIndex = value;
                setState(() {});
              },
              currentIndex: selectedIndex,
              items: [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(
                    Icons.home_outlined,
                    color:
                    selectedIndex == 0 ? AppColors.cyanColor : Colors.black,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Notification',
                  icon: Icon(
                    Icons.notifications_none,
                    color:
                    selectedIndex == 1 ? AppColors.cyanColor : Colors.black,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Setting',
                  icon: Icon(
                    Icons.settings,
                    color:
                    selectedIndex == 2 ? AppColors.cyanColor : Colors.black,
                  ),
                ),

              ]),
        ),
      ),
      body: screens[selectedIndex],
    );
  }
}
