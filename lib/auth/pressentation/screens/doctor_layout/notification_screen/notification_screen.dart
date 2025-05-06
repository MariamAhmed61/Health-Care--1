import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';

class NotificationScreen extends StatelessWidget {
  static const routeName = 'doctornotification';

  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Center(
            child: Text(
              'Notifications ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/apple.png'),
                              radius: 30,
                            ),
                            title: const Text('Mr. Jack sparrow',style: TextStyle(
                              color: Colors.white
                            ),),
                            subtitle: const Text(
                                'want to fix appoinment with you for medical checkup.'
                              ,style: TextStyle(
                                color: Colors.white
                            ),),
                            trailing: GestureDetector(
                                onTap: () {}, child: const Icon(Icons.close,color: Colors.white,)),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 16, bottom: 8),
                          child: Row(
                            children: [
                              Text(
                                '5 min ago',
                              style: TextStyle(
                              color: Colors.white,
                                fontSize: 15
                          ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: 4,
            ),
          )
        ],
      ),
    );
  }
}
