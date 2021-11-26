import 'package:flutter/material.dart';

abstract class Languages {

  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get languageName;

  String get languageCode;

  String get appName;

  String get appTitle;
}
