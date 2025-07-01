import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProvider extends ChangeNotifier {
  String language = 'en';

  void changeLanguage(String newLang) {
    if (newLang == language) return;
    language = newLang;
    savedLanguage(newLang);
    notifyListeners();
  }

  void savedLanguage(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', lang);
  }

  Future<void> getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lan = prefs.getString('language') ?? 'en';
    language = lan;
    notifyListeners();
    }
}