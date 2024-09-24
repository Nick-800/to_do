import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  String? lang;

  switchLanguage(String s) async {
    lang = s;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', lang ?? "en");
    notifyListeners();
  }

  getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lang = prefs.getString('lang') ?? 'en';
    notifyListeners();
  }
}
