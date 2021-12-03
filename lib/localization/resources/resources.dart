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

  // Login
  String get welcome;
  String get login;
  String get logout;
  String get successfullyLogout;

  // Navigation
  String get balance;
  String get statistics;
  String get settings;

  // Charts
  String get available;
}
