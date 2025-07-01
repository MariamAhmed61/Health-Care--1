import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_app/auth/pressentation/cubits/appointment_cubit/appointment_cubit.dart';
import 'package:health_care_app/auth/pressentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:health_care_app/auth/pressentation/cubits/available_slot_cubit/available_slots_cubit.dart';
import 'package:health_care_app/auth/pressentation/cubits/doctor_cubit/doctor_cubit.dart';
import 'package:health_care_app/auth/data/services/auth_service.dart';
import 'package:health_care_app/core/helper/on_generate_routs.dart';
import 'package:health_care_app/providers/setting_provider.dart';
import 'package:health_care_app/splash/views/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingProvider = SettingProvider();
  await settingProvider.getLang();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => settingProvider),
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(AuthService()),
        ),
        BlocProvider<DoctorCubit>(
          create: (_) => DoctorCubit(),
        ),
        BlocProvider<AppointmentCubit>(
          create: (_) => AppointmentCubit(),
        ),
        BlocProvider<AvailableSlotsCubit>(
            create: (_) => AvailableSlotsCubit()
        ),
        BlocProvider<AppointmentCubit>(
            create: (_) => AppointmentCubit()
        ),
      ],
      child: const HealthCare(),
    ),
  );
}

class HealthCare extends StatelessWidget {
  const HealthCare({super.key});

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);

    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      locale: Locale(settingProvider.language),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      initialRoute: SplashScreen.routeName,
    );
  }
}