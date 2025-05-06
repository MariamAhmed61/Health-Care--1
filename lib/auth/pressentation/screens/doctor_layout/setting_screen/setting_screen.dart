import 'package:flutter/material.dart';
import 'package:health_care_app/auth/pressentation/screens/doctor_layout/setting_screen/wallet_screen.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = 'doctorsetting';

  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const Center(
                child: Text('Setting',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black
                ),),
              ),
             const Padding(
                padding:  EdgeInsets.all(16.0),
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
                      padding:  EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Dr.Alexa',style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),),
                          Padding(
                            padding:  EdgeInsets.symmetric(vertical: 8.0),
                            child: Text('Heart Specilist',style: TextStyle(
                                fontSize: 15,
                                color: Colors.black
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
                                  color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),),
                            ],
                          )

                        ],
                      ),
                    )

                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pushNamed(WalletScreen.routeName);

                },
                child:const Row(
                  children: [
                    Icon((Icons.wallet)),
                     SizedBox(width: 10,),
                     Text('My Wallet',style: TextStyle(
                        fontSize: 18,
                        color: Colors.black
                    ),),
                  ],
                ),
              ),
            const Padding(
               padding:  EdgeInsets.all(8.0),
               child:  Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
             ),
             const Text('Security',style: TextStyle(
                color: Colors.black,
                fontSize: 18
              ),),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: (){},
                  child:const Row(
                    children: [
                      Icon(Icons.lock_clock_rounded,color: Colors.black,),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Change password',style: TextStyle(
                        color: Colors.black
                      ),)

                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: (){},
                  child:const Row(
                    children: [
                      Icon(Icons.lock_clock_rounded,color: Colors.black,),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Forgot password',style: TextStyle(
                          color: Colors.black
                      ),)

                    ],
                  ),
                ),
              ),
              const Padding(
                padding:  EdgeInsets.all(8.0),
                child:  Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ),
              const Text('General',style: TextStyle(
                  color: Colors.black,
                  fontSize: 18
              ),),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: (){},
                  child:const Row(
                    children: [
                      Icon(Icons.notifications,color: Colors.black,),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Notification',style: TextStyle(
                          color: Colors.black
                      ),)

                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: (){},
                  child:const Row(
                    children: [
                      Icon(Icons.language,color: Colors.black,),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Languages',style: TextStyle(
                          color: Colors.black
                      ),)

                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: (){},
                  child:const Row(
                    children: [
                      Icon(Icons.question_mark,color: Colors.black,),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Help and Support',style: TextStyle(
                          color: Colors.black
                      ),)

                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
