import 'package:flutter/material.dart';
import 'package:health_care_app/patient_layout/patient_home_screen/doctor_profile.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       appBar: AppBar(
  iconTheme: IconThemeData(
      color: Colors.black
  ),
  backgroundColor: Colors.transparent,
  elevation: 0,
  title: Center(
      child: Text('Doctors',style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 25
      ),),
  ),
),
        body: ListView.builder(itemCount: 5,itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return DoctorProfile();
                },));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffE8E8E8),
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading:  CircleAvatar(
                        backgroundImage: AssetImage('assets/images/apple.png'),
                        radius: 30,
                      ),
                      title: Text('Dr.Alexa Sharma',style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                      subtitle: Text('10:00 AM to 7:00PM',style: TextStyle(
                        fontSize: 10
                      ),),

                      trailing: Icon(Icons.favorite_border),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 90.0),
                      child: Row(
                        children: [
                          Icon(Icons.star_rounded,color: Color(0xffFFC700),),
                          Text('4.9')
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },),
      ),
    );
  }
}
