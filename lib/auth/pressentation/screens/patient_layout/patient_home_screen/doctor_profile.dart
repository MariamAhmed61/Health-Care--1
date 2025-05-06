
import 'package:flutter/material.dart';
import 'package:health_care_app/auth/pressentation/screens/patient_layout/patient_home_screen/appointment_time.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:AppColors.primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(
            color: Colors.white
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor
              ),
              child: Column(
                children: [
                  Text('Doctor’s Profile',style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Center(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.primaryColor,
                            radius: 33,
                            child: Center(
                              child: CircleAvatar(
                                backgroundImage: AssetImage('assets/images/apple.png'),
                                radius: 30,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Padding(
                            padding:  EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Dr.Alexa',style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),),
                                Padding(
                                  padding:  EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text('Heart Specilist',style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white
                                  ),),
                                ),
                                Row(
                                  children: [
                                    Icon((Icons.star_rounded),color: Color(0xffFFC700),),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('4.8',style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),),

                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    color: Color(0xffD9D9D9),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(
                                          '\$100',style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          topLeft: Radius.circular(16)
                        ),
                        color: Colors.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Contact Details',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon((Icons.phone)),
                                  SizedBox(width: 10,),
                                  Text('91+8546652338',style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black
                                  ),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon((Icons.mail)),
                                  SizedBox(width: 10,),
                                  Text('alexasharma@gmail.com',style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black
                                  ),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon((Icons.location_pin)),
                                  SizedBox(width: 10,),
                                  Text('k-74,saraswati vihar,\nph-1rohini,delhi-110085',style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black
                                  ),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.asset('assets/images/location.png',fit: BoxFit.cover,),
                            ),
                            Center(
                              child: ElevatedButton(onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                  return AppointmentTime();
                                },));

                              }, child: Text('BOOK APPOINMENT',style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),),style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                minimumSize: Size(300, 50)

                              ),),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),


    );
  }
}
