import 'package:flutter/material.dart';
import 'package:health_care_app/doctor_layout/home_screen/home_screen.dart';
import 'package:health_care_app/doctor_layout/notification_screen/notification_screen.dart';
import 'package:health_care_app/doctor_layout/setting_screen/setting_screen.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';

class DoctorLayoutScreen extends StatefulWidget {
  static const routeName = 'doctorlayout';

  const DoctorLayoutScreen({super.key});

  @override
  State<DoctorLayoutScreen> createState() => _DoctorLayoutScreenState();
}

class _DoctorLayoutScreenState extends State<DoctorLayoutScreen> {
  @override
  int selectedIndex = 0;
  List<Widget> screens = [
    DoctorHomeScreen(),
    NotificationScreen(),
    SettingScreen(),

  ];
  Widget build(BuildContext context) {
    return  Scaffold(
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
                    selectedIndex == 0 ? AppColors.primaryColor : Colors.black,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Notification',
                  icon: Icon(
                    Icons.notifications_none,
                    color:
                    selectedIndex == 1 ? AppColors.primaryColor : Colors.black,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Setting',
                  icon: Icon(
                    Icons.settings,
                    color:
                    selectedIndex == 2 ? AppColors.primaryColor : Colors.black,
                  ),
                ),

              ]),
        ),
      ),
      body: screens[selectedIndex],
    );
  }
}
