import 'package:flutter/material.dart';
import 'package:health_care_app/auth/pressentation/cubits/doctor_cubit/doctor_cubit.dart';
import 'package:health_care_app/generated/l10n.dart';
import 'package:health_care_app/patient_layout/presentation/cubits/language_cubit/language_cubit.dart';
import 'package:provider/provider.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:health_care_app/auth/pressentation/screens/auht_screen/user_selection_screen.dart';

class ShowDialog {
  static void showNotificationDialog({
    required BuildContext context,
    required bool receiveNotifications,
    required bool vibration,
    required Function(bool, bool) onSave,
  }) {
    bool tempReceive = receiveNotifications;
    bool tempVibration = vibration;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.of(context).notification),
          content: StatefulBuilder(
            builder: (context, setStateDialog) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwitchListTile(
                    title: Text(S.of(context).receiveNotifications),
                    value: tempReceive,
                    activeColor: AppColors.primaryColor,
                    onChanged: (val) {
                      setStateDialog(() => tempReceive = val);
                    },
                  ),
                  SwitchListTile(
                    title: Text(S.of(context).vibration),
                    value: tempVibration,
                    activeColor: AppColors.primaryColor,
                    onChanged: (val) {
                      setStateDialog(() => tempVibration = val);
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(S.of(context).cancel,
                  style: const TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () {
                onSave(tempReceive, tempVibration);
                Navigator.pop(context);
              },
              child: Text(S.of(context).save,
                  style: const TextStyle(color: AppColors.primaryColor)),
            ),
          ],
        );
      },
    );
  }

  static void showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final currentLang = context.read<LanguageCubit>().state.languageCode;

        return AlertDialog(
          title: Text(S.of(context).language),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("English"),
                trailing: currentLang == 'en'
                    ? const Icon(Icons.check, color: AppColors.primaryColor)
                    : null,
                onTap: () {
                  context.read<LanguageCubit>().changeLanguage('en');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("العربية"),
                trailing: currentLang == 'ar'
                    ? const Icon(Icons.check, color: AppColors.primaryColor)
                    : null,
                onTap: () {
                  context.read<LanguageCubit>().changeLanguage('ar');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static void showLogoutDialog(BuildContext context) {

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.of(context).logoutConfirmationTitle),
          content: Text(S.of(context).areYouSureLogout),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                S.of(context).cancel,
                style: const TextStyle(color: AppColors.primaryColor),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // يقفل الديالوج

                Navigator.of(context).pushNamedAndRemoveUntil(
                  UserSelection.routeName,
                  (route) => false,
                );
              },
              child: Text(
                S.of(context).yes,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showEditPriceDialog({
    required BuildContext context,
    required int currentPrice,
  }) async {
    final controller = TextEditingController(text: currentPrice.toString());

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).editPrice),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: S.of(context).enterNewPrice,
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              S.of(context).cancel,
              style: TextStyle(color: Colors.black),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final newPrice = int.tryParse(controller.text);
              if (newPrice != null) {
                context.read<DoctorLayoutCubit>().updateDoctorPrice(newPrice);
                Navigator.of(context).pop();
              }
            },
            child: Text(
              S.of(context).save,
              style: TextStyle(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
