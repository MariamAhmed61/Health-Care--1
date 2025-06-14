import 'package:flutter/material.dart';
import 'package:health_care_app/patient_layout/patient_home_screen/doctor_profile.dart';
import 'package:health_care_app/patient_layout/patient_home_screen/search_screen.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';

class PatientHomeScreen extends StatelessWidget {
  static const routeName = 'patienthome';

  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text('Good Morning!',
                                style: TextStyle(color: Colors.black, fontSize: 15)),
                            Text(
                              'Jack',
                              style: TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),

                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/apple.png'),
                        radius: 30,
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius:  BorderRadius.circular(16)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text('Lets Find Your Specialist',style: TextStyle(
                            color: Colors.white
                          ),),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Search....',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                          return SearchScreen();
                                        },));
                                      },
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.grey.withOpacity(.2),
                child: Column(
     children: [
      SizedBox(
        height: 100,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 7,
          itemBuilder: (context, index) {
            return  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(24)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text('19',style: TextStyle(
                          fontSize: 20,
                          color: Colors.black
                      ),),
                      Text('MON',style: TextStyle(
                          fontSize: 15,
                          color: Colors.black
                      ),)
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
         child: Container(
           width: double.infinity,
           decoration: BoxDecoration(
             color: Colors.white,

             borderRadius: BorderRadius.circular(16)
           ),
           child: Column(
             children: [
               Text('11 Wednesday',style: TextStyle(
                 color: AppColors.primaryColor,
                 fontWeight: FontWeight.bold,
                 fontSize: 20,
               ),),
               Row(
                 children: [
                   Text('9 AM    ------------------------',
                   style: TextStyle(
                     fontSize: 20,
                     color: AppColors.primaryColor
                   ),),
                 ],
               ),
               Row(
                 children: [
                   Text('10 AM', style: TextStyle(
                       fontSize: 20,
                       color: AppColors.primaryColor
                   ),),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                     decoration: BoxDecoration(
                       color: AppColors.primaryColor.withOpacity(0.2),
                       borderRadius: BorderRadius.circular(16),
                     ),
                       child: Column(
                         children: [
                           Row(
                             children: [
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Text('Dr Olivia',style: TextStyle(
                                   color: AppColors.primaryColor,
                                   fontWeight: FontWeight.bold,
                                   fontSize: 25
                                 ),),
                               ),
                               SizedBox(
                                 width: 60,
                               ),
                               CircleAvatar(
                                 radius: 15,
                                 backgroundColor: Colors.white,
                                 child: Icon(Icons.check,color: AppColors.primaryColor,),
                               ),

                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: CircleAvatar(
                                   backgroundColor: Colors.white,
                                   radius: 15,
                                   child: Icon(Icons.close,color: AppColors.primaryColor,),
                                 ),
                               )
                             ],

                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text('Treatment and prevention of\n skin and photodermatitis'),
                           )

                         ],
                       ),
                       
                     ),
                   )
                 ],
               ),


             ],
             
           ),
           
         ),
       ),
       SizedBox(height: 10,),
       Expanded(
         child: ListView.builder(itemCount: 4,itemBuilder: (context, index) {
           return  Column(
             children: [
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
                 child: Container(
                   decoration: BoxDecoration(
                       color: AppColors.primaryColor.withOpacity(0.2),
                       borderRadius: BorderRadius.circular(16)
                   ),
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: ListTile(
                       leading: const CircleAvatar(
                         backgroundImage:
                         AssetImage('assets/images/apple.png'),
                         radius: 30,
                       ),
                       title: const Text('Mr. Jack sparrow',style: TextStyle(
                           color: AppColors.primaryColor
                       ),),
                       subtitle: const Text(
                         'want to fix appoinment with you for medical checkup.'
                         ,style: TextStyle(
                           color: Colors.black
                       ),),

                     ),
                   ),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
                 child: Row(children: [
                   Container(
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(16),
                         color: Colors.white

                     ),
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                       child: Row(
                         children: [
                           Icon(Icons.star_rounded,color: AppColors.primaryColor,),
                           SizedBox(
                             width: 20,
                           ),
                           Text('5',style: TextStyle(
                               color: AppColors.primaryColor,
                               fontSize: 15
                           ),),
                         ],
                       ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(16),
                           color: Colors.white

                       ),
                       child: Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
                         child: Row(
                           children: [
                             Icon(Icons.chat,color: AppColors.primaryColor,),
                             SizedBox(
                               width: 20,
                             ),
                             Text('60',style: TextStyle(
                                 color: AppColors.primaryColor
                             ),),
                           ],
                         ),
                       ),
                     ),
                   ),
                   SizedBox(
                     width: 90,
                   ),
                   CircleAvatar(
                     radius: 15,
                     backgroundColor: Colors.white,
                     child: Icon(Icons.question_mark,color: AppColors.primaryColor,),
                   ),

                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: CircleAvatar(
                       backgroundColor: Colors.white,
                       radius: 15,
                       child: Icon(Icons.favorite,color: AppColors.primaryColor,),
                     ),
                   )
                 ],),
               )
             ],
           );
         },),
       )



    ],
    )

              ),
            ),

          ),

        ],
      ),
    );
  }
}
