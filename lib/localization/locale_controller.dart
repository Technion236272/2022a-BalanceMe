// ================= Locale Controller Functions =================
import 'package:balance_me/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/localization/languages_controller.dart';
import 'dart:io';
import 'package:balance_me/global/constants.dart' as gc;

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(gc.prefSelectedLanguageCode, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  String languageCode = Platform.localeName.split('_')[0];
  if (!LanguageController().supportedLanguageCodesList().contains(languageCode)) {
    languageCode = LanguageController().defaultLanguage.languageCode;
  }
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  return languageCode.isNotEmpty ? Locale(languageCode, '') : Locale(LanguageController().defaultLanguage.languageCode, '');
}

void changeLanguage(BuildContext context, String selectedLanguageCode) async {
  Locale _locale = await setLocale(selectedLanguageCode);
  BalanceMeApp.setLocale(context, _locale);
  GoogleAnalytics.instance.logChangeLanguage(selectedLanguageCode);
}

List<Locale> getSupportedLocales() {
  List<Locale> supportedLocales = [];
  for (var language in LanguageController().supportedLanguages) {
    supportedLocales.add(Locale(language.languageCode, ''));
  }
  return supportedLocales;
}
