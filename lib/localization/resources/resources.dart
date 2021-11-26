import 'package:flutter/material.dart';

abstract class Languages {

  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get languageName;

  String get languageCode;

  String get appName;

  String get appTitle;

  String get settingsTitle;

  String get profileSettings;

  String get groupSettings;

  String get passwordSettings;

  String get darkModeSettings;

  String get endOfMonthSettings;

  String get languageSettings;

  String get versionSettings;
}
