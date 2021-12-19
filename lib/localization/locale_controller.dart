// ================= Locale Controller Functions =================
import 'package:flutter/material.dart';
import 'package:balance_me/main.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/localization/languages_controller.dart';
import 'dart:io';

Future<Locale> getLocale() async {
  String languageCode = Platform.localeName.split('_')[0];  // device language
  if (!LanguageController().supportedLanguageCodesList().contains(languageCode)) {
    languageCode = LanguageController().defaultLanguage.languageCode;
  }
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  return languageCode.isNotEmpty ? Locale(languageCode, '') : Locale(LanguageController().defaultLanguage.languageCode, '');
}

void changeLanguage(BuildContext context, String selectedLanguageCode) async {
  BalanceMeApp.setLocale(context, _locale(selectedLanguageCode));
  GoogleAnalytics.instance.logChangeLanguage(selectedLanguageCode);
}

List<Locale> getSupportedLocales() {
  List<Locale> supportedLocales = [];
  for (var language in LanguageController().supportedLanguages) {
    supportedLocales.add(Locale(language.languageCode, ''));
  }
  return supportedLocales;
}
