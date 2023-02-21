import 'package:flutter/cupertino.dart';
import 'package:food_e/core/SharedPreferencesClass.dart';


class ThemeModeProvider with ChangeNotifier
{
  bool _isDarkMode = false;

  bool get darkmode => _isDarkMode;

  void changeThemeMode({required bool darkMode}) async {
    _isDarkMode = darkMode;
    await SharedPreferencesClass().set_dark_mode(option: darkMode);
    notifyListeners();
  }

  void getThemeMode() async {
    try {
      _isDarkMode = await SharedPreferencesClass().get_dark_mode_options();
    } catch (e) {
      _isDarkMode = false;
    }
    notifyListeners();
  }
}