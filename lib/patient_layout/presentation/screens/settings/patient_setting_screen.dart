import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/auth/data/services/auth_service.dart';
import 'package:health_care_app/generated/l10n.dart';
import 'package:health_care_app/patient_layout/presentation/cubits/language_cubit/language_cubit.dart';

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
               Center(
                child: Text(
                  S.of(context).settings,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black),
                ),
              ),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: () {},
                child:  Row(
                  children: [
                    const Icon((Icons.wallet)),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      S.of(context).my_wallet,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
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
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'patient_profile');
                },
                child:  Row(
                  children: [
                    const Icon(Icons.person),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      S.of(context).profile,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
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
              Text(
                S.of(context).security,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: () {
                    // showDialog(
                    //   context: context,
                    //   builder: (_) {
                    //     String newPassword = '';
                    //     return AlertDialog(
                    //       title:  Text(S.of(context).change_password),
                    //       content: TextField(
                    //         obscureText: true,
                    //         onChanged: (value) => newPassword = value,
                    //         decoration: InputDecoration(labelText: S.of(context).new_password),
                    //       ),
                    //       actions: [
                    //         TextButton(
                    //           onPressed: () async {
                    //             Navigator.pop(context);
                    //             ScaffoldMessenger.of(context).showSnackBar(
                    //               SnackBar(content: Text(S.of(context).password_changed)),
                    //             );
                    //           },
                    //           child: Text(S.of(context).change),
                    //         ),
                    //       ],
                    //     );
                    //   },
                    // );
                  },
                  child:   Row(
                    children: [
                      const Icon(
                        Icons.lock_clock_rounded,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        S.of(context).change_password,
                        style: const TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: () {
                     Navigator.pushNamed(context, 'forgotPassword',
                                      arguments:'patient');
                  },
                  child:  Row(
                    children: [
                      const Icon(
                        Icons.lock_clock_rounded,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        S.of(context).forgot_password,
                        style: const TextStyle(color: Colors.black),
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
               Text(
                S.of(context).general,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: () {},
                  child:  Row(
                    children: [
                      const Icon(
                        Icons.notifications,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        S.of(context).notifications,
                        style: const TextStyle(color: Colors.black),
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
                          String selectedLang = context.read<LanguageCubit>().state.languageCode == 'ar' ? 'Arabic' : 'English'; 

                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                title:  Text(S.of(context).select_language),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      title:  Text(S.of(context).english),
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
                                      title:  Text(S.of(context).arabic),
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
                                     String langCode = context.read<LanguageCubit>().state.languageCode;
                                      if(selectedLang == 'English' && langCode != 'en') {
                                        context.read<LanguageCubit>().changeLanguage('en');
                                      } else if(selectedLang == 'Arabic' && langCode != 'ar') {
                                        context.read<LanguageCubit>().changeLanguage('ar');
                                      }
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('${S.of(context).language_changed_to}  $selectedLang')),
                                      );
                                    },
                                    child:  Text(S.of(context).save),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  child:  Row(
                    children: [
                      const Icon(
                        Icons.language,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        S.of(context).language,
                        style: const TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: () {},
                  child:  Row(
                    children: [
                      const Icon(
                        Icons.question_mark,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        S.of(context).help_support,
                        style: const TextStyle(color: Colors.black),
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
