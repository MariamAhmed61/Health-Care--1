import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';

class AppointmentTime extends StatelessWidget {
  const AppointmentTime({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.primaryColor),
          title: Text(
            'Doctor’s Details',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
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
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr.Alexa',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Heart Specilist',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'DATE',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text('August'),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffD9D9D9),
                          borderRadius: BorderRadius.circular(24)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              '19',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            Text(
                              'MON',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'TIME',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.3,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio:1.6),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color(0xffD9D9D9)
                      ),
                      child: Center(child: Text('10:00 AM',style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),)),
                    ),
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffD9D9D9),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Center(
                        child: Text('Payment Method',style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold
                        ),),
                      ),

                    ),
                    TextButton(onPressed: (){}, child: Text('CASH',style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold
                    ),)),
                    Text('OR'),
                    TextButton(onPressed: (){}, child: Text('VISA',style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold
                    ),)),
                  ],),
                ),
              ),
            ),

            Center(
              child: ElevatedButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return AppointmentTime();
                },));

              }, child: Text('DONE',style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  minimumSize: Size(300, 50)

              ),),
            )
          ],
        ),
      ),
    );
  }
}
