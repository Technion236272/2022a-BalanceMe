// ================= Languages Controller Class =================
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/localization/resources/resources_he.dart';
import 'package:balance_me/localization/resources/resources_en.dart';
import 'package:balance_me/localization/resources/resources_ru.dart';

class LanguageController {
  static final Languages _defaultLanguage = LanguageEn();
  static final List _supportedLanguages = [LanguageEn(), LanguageHe(), LanguageRu()];

  Languages get defaultLanguage => _defaultLanguage;
  List get supportedLanguages => _supportedLanguages;

  List supportedLanguageCodesList() {
    List supportedLanguageCodesList = [];
    for (Languages language in _supportedLanguages) {
      supportedLanguageCodesList.add(language.languageCode);
    }
    return supportedLanguageCodesList;
  }
}

class LanguageData {
  final String name;
  final String languageCode;

  LanguageData(this.name, this.languageCode);

  static List<LanguageData> languageList() {
    List<LanguageData> languageList = <LanguageData>[];
    for (var language in LanguageController().supportedLanguages) {
      languageList.add(LanguageData(language.languageName, language.languageCode));
    }
    return languageList;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => LanguageController().supportedLanguageCodesList().contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    List supportedLanguageCodesList = LanguageController().supportedLanguageCodesList();
    int languageIndex = supportedLanguageCodesList.indexWhere((languageCode) => locale.languageCode == languageCode);
    if (languageIndex == -1) {
      return LanguageController().defaultLanguage;
    }
    return LanguageController().supportedLanguages[languageIndex];
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
