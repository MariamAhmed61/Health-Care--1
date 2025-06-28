import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:health_care_app/auth/data/services/auth_service.dart';
import 'package:health_care_app/auth/pressentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:health_care_app/auth/pressentation/screens/auht_screen/login_screen.dart';
import 'package:health_care_app/core/helper/on_generate_routs.dart';
import 'package:health_care_app/firebase_options.dart';
import 'package:health_care_app/patient_layout/presentation/cubits/doctor_cubit/doctor_cubit.dart';
import 'package:health_care_app/patient_layout/presentation/cubits/language_cubit/language_cubit.dart';
import 'package:health_care_app/patient_layout/presentation/cubits/language_cubit/language_state.dart';
import 'package:health_care_app/patient_layout/presentation/screens/medicine/sale_screen.dart';
import 'package:health_care_app/patient_layout/presentation/screens/payment/payment_details.dart';
import 'package:health_care_app/splash/views/splash_screen.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const HealthCare());
}

class HealthCare extends StatelessWidget {
  const HealthCare({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DoctorCubit()..fetchDoctors()),
        BlocProvider(create: (context) => AuthCubit(AuthService())),
        BlocProvider(create: (context) => LanguageCubit())
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: onGenerateRoute,
            initialRoute: SplashScreen.routeName,
            locale: Locale(state.languageCode),
            supportedLocales: const [
              Locale('en'), // English
              Locale('ar'), // Arabic
            ],
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}
