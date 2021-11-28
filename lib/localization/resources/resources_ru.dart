// ================= A Class For Russian Language =================
import 'package:balance_me/localization/resources/resources.dart';

class LanguageRu extends Languages {
  // General
  @override
  String get languageName => "русский";

  @override
  String get languageCode => "ru";

  @override
  String get appName => "BalanceMe";

  @override
  String get appTitle => "BalanceMe";


  @override
  String get signUpTitle => "регистрация";

  @override
  String get emailText => "электронный адрес";

  // Login
  @override
  String get welcome => "Welcome";

  @override
  String get login => "вход";

  @override
  String get logout => "Logout";

  @override
  String get successfullyLogout => "Successfully logged out";

  // Navigation
  @override
  String get balance => "Balance";

  @override
  String get statistics => "Statistics";

  @override
  String get settings => "Settings";

}
