import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:health_care_app/generated/l10n.dart';
import 'package:health_care_app/patient_layout/presentation/cubits/doctor_cubit/doctor_cubit.dart';
import 'package:health_care_app/patient_layout/presentation/screens/home/patient_home_screen.dart';
import 'package:health_care_app/patient_layout/presentation/screens/medicine/sale_screen.dart';
import 'package:health_care_app/patient_layout/presentation/screens/settings/patient_setting_screen.dart';

class PatientLayoutScreen extends StatefulWidget {
  static const String routeName = '/patient';
  const PatientLayoutScreen({super.key});

  @override
  State<PatientLayoutScreen> createState() => _PatientLayoutScreenState();
}

class _PatientLayoutScreenState extends State<PatientLayoutScreen> {
  int selectedIndex = 0;
  List<Widget> screens = [
     PatientHomeScreen(),
    const Sale_Screen(),
    const PatientSettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: screens[selectedIndex],
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
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedIconTheme:
                  const IconThemeData(color: AppColors.primaryColor, size: 35),
              unselectedIconTheme:
                  const IconThemeData(color: Colors.black, size: 20),
              items: [
                BottomNavigationBarItem(
                  label: S.of(context).home,
                  icon: const Icon(
                    Icons.home_outlined,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Sales',
                  icon: Icon(
                    Icons.medical_services_outlined,
                  ),
                ),
                BottomNavigationBarItem(
                  label: S.of(context).settings,
                  icon: const Icon(
                    Icons.settings,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
