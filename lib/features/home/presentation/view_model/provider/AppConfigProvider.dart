import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppConfigProvider extends ChangeNotifier {
  String appLanguage = 'en';
  ThemeMode mode = ThemeMode.light;


  void setNewLanguage(String newLang) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (appLanguage == newLang) return;
    appLanguage = newLang;
    prefs.setString('language', newLang);
    notifyListeners();
  }
  void setNewMode(ThemeMode newMode)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(mode==newMode) return;
    mode=newMode;
    prefs.setString('theme', mode==ThemeMode.light?'light' :'dark');
    notifyListeners();
  }
}

