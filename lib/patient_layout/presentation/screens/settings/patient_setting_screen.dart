import 'package:flutter/material.dart';

class PatientSettingScreen extends StatelessWidget {
  static const routeName = 'patient-setting';

  const PatientSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Setting',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black),
                ),
              ),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: () {},
                child: const Row(
                  children: [
                    Icon((Icons.wallet)),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'My Wallet',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ),
              const Text(
                'Security',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        String newPassword = '';
                        return AlertDialog(
                          title: Text('Change Password'),
                          content: TextField(
                            obscureText: true,
                            onChanged: (value) => newPassword = value,
                            decoration: InputDecoration(labelText: 'New Password'),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                // await AuthService().changePassword(newPassword);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Password changed successfully")),
                                );
                              },
                              child: Text("Change"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child:  const Row(
                    children: [
                      Icon(
                        Icons.lock_clock_rounded,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Change password',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'forgotPassword');
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.lock_clock_rounded,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Forgot password',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ),
              const Text(
                'General',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: () {},
                  child: const Row(
                    children: [
                      Icon(
                        Icons.notifications,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Notification',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          String selectedLang = 'English'; // Default value, can be dynamic later

                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                title: const Text('Select Language'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      title: const Text('English'),
                                      trailing: Checkbox(
                                        value: selectedLang == 'English',
                                        onChanged: (_) {
                                          setState(() {
                                            selectedLang = 'English';
                                          });
                                        },
                                      ),
                                      onTap: () {
                                        setState(() {
                                          selectedLang = 'English';
                                        });
                                      },
                                    ),
                                    ListTile(
                                      title: const Text('Arabic'),
                                      trailing: Checkbox(
                                        value: selectedLang == 'Arabic',
                                        onChanged: (_) {
                                          setState(() {
                                            selectedLang = 'Arabic';
                                          });
                                        },
                                      ),
                                      onTap: () {
                                        setState(() {
                                          selectedLang = 'Arabic';
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      // TODO: save selectedLang to storage or app state
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Language changed to $selectedLang")),
                                      );
                                    },
                                    child: const Text("Save"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.language,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Languages',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: () {},
                  child: const Row(
                    children: [
                      Icon(
                        Icons.question_mark,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Help and Support',
                        style: TextStyle(color: Colors.black),
                      )
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
