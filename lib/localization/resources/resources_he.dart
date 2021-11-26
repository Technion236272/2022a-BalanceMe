import 'package:balance_me/localization/resources/resources.dart';

class LanguageHe extends Languages {
  @override

  //important- LRM- string from right to left
  String get languageName => "‎עברית";

  @override
  String get languageCode => "he";

  @override
  String get appName => "BalanceMe";

  @override
  String get appTitle => "BalanceMe";
  @override
  String get settingsTitle => "‎הגדרות";
  @override
  String get profileSettings => "‎פרופיל";
  @override
  String get groupSettings => "קבוצה‎";

  @override
  String get passwordSettings => "שינוי סיסמה‎ ";

  @override
  String get darkModeSettings => "‎מצב כהה";
  @override
  String get endOfMonthSettings => "סוף החודש‎";
  @override
  String get languageSettings => "‎שפה";
  @override
  String get versionSettings => "גרסה‎";
}
