import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/generated/l10n.dart';

class PatientProfile extends StatelessWidget {
  static const String routeName = 'patient_profile';
  const PatientProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            Text(S.of(context).profile,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.transparent,
             child: Icon(
                Icons.person,
                size: 100,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Patient Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Email: patient@example.com',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 10),
            Text(
              'Phone: +1234567890',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            Text(
              'Address: 123 Main St, Anytown, USA',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality to edit profile
              },
              child: Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality to log out
              },
              child: Text('Log Out'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
      
          ],
        ),
      ),
    );
  }
}