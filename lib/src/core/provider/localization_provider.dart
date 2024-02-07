import 'package:flutter/material.dart';
import 'package:moon/src/core/constant/app_constants.dart';
import 'package:moon/src/core/data/dio/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider extends ChangeNotifier {
  DioClient? dioClient;
  final SharedPreferences? sharedPreferences;

  LocalizationProvider({required this.sharedPreferences, required this.dioClient}) {
    _loadCurrentLanguage();
  }
  String _appName = 'Moon';

  String get appName => _appName;
  Locale _locale = const Locale('zh', 'CN');
  Locale get locale => _locale;

  void setAppTitle(String newAppName) {
    _appName = newAppName;
    notifyListeners();
  }

  void setLanguage(Locale locale) {
    _locale = locale;
    _saveLanguage(_locale);
    notifyListeners();
  }

  _loadCurrentLanguage() async {
    _locale = Locale(sharedPreferences!.getString(AppConstants.languageCode) ?? AppConstants.languages[0].languageCode!, sharedPreferences!.getString(AppConstants.countryCode) ?? AppConstants.languages[0].countryCode);
    notifyListeners();
  }

  _saveLanguage(Locale locale) async {
    sharedPreferences!.setString(AppConstants.languageCode, locale.languageCode);
    sharedPreferences!.setString(AppConstants.countryCode, locale.countryCode!);
  }
}
