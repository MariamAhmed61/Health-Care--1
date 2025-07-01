import 'package:flutter/material.dart';
import 'package:health_care_app/auth/pressentation/cubits/doctor_cubit/doctor_cubit.dart';
import 'package:provider/provider.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:health_care_app/providers/setting_provider.dart';
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
        final loc = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(loc.notification),
          content: StatefulBuilder(
            builder: (context, setStateDialog) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwitchListTile(
                    title: Text(loc.receiveNotifications),
                    value: tempReceive,
                    activeColor: AppColors.primaryColor,
                    onChanged: (val) {
                      setStateDialog(() => tempReceive = val);
                    },
                  ),
                  SwitchListTile(
                    title: Text(loc.vibration),
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
              child: Text(loc.cancel, style: const TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () {
                onSave(tempReceive, tempVibration);
                Navigator.pop(context);
              },
              child: Text(loc.save, style: const TextStyle(color: AppColors.primaryColor)),
            ),
          ],
        );
      },
    );
  }

  static void showLanguageDialog(BuildContext context) {
    final provider = Provider.of<SettingProvider>(context, listen: false);
    final loc = AppLocalizations.of(context)!;
    String currentLang = provider.language;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(loc.language),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("English"),
                trailing: currentLang == 'en'
                    ? const Icon(Icons.check, color: AppColors.primaryColor)
                    : null,
                onTap: () {
                  provider.changeLanguage('en');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("العربية"),
                trailing: currentLang == 'ar'
                    ? const Icon(Icons.check, color: AppColors.primaryColor)
                    : null,
                onTap: () {
                  provider.changeLanguage('ar');
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
    final loc = AppLocalizations.of(context)!;

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(loc.logoutConfirmationTitle),
            content: Text(loc.areYouSureLogout),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  loc.cancel,
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
                  loc.yes,
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
            title: Text(AppLocalizations.of(context)!.editPrice),
            content: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.enterNewPrice,
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(AppLocalizations.of(context)!.cancel,
                style: TextStyle(color: Colors.black),),
              ),
              ElevatedButton(
                onPressed: () {
                  final newPrice = int.tryParse(controller.text);
                  if (newPrice != null) {
                    context.read<DoctorCubit>().updateDoctorPrice(newPrice);
                    Navigator.of(context).pop();
                  }
                },
                child: Text(AppLocalizations.of(context)!.save,
                style: TextStyle(color: AppColors.primaryColor),),
              ),
            ],
            ),
        );
  }
}