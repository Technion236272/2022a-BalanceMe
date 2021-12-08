// ================= An Abstract Class For Language =================
import 'package:flutter/material.dart';

abstract class Languages {

  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  // General
  String get languageName;
  String get languageCode;
  String get appName;
  String get appTitle;

//settings
  String get settingsTitle;
  String get profileSettings;
  String get groupSettings;
  String get passwordSettings;
  String get darkModeSettings;
  String get endOfMonthSettings;
  String get languageSettings;
  String get versionSettings;
  String get newPassword;

  // Login
  String get welcome;
  String get login;
  String get logout;
  String get successfullyLogout;
  String get signUpTitle;
  String get emailText;
  String get password;
  String get forgotPassword;
  String get signIn;
  String get loginError;
  String get nullDetails;
  String get signUpError;
  String get confirmPassword;
  String get invalidPasswords;
  //password recovery
  String get recoverPassword;
  String get forgotPasswordLarge;
  String get confirmEmail;
  String get send;
  String get emailSent;
  // Navigation
  String get balance;
  String get statistics;
  String get settings;

  // Charts
  String get available;


}
