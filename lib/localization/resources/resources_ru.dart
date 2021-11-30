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
  String get welcome => "Добро пожаловать";

  @override
  String get login => "вход";

  @override
  String get logout => "выход";

  @override
  String get successfullyLogout => "удачный выход";

  // Navigation
  @override
  String get balance => "Balance";

  @override
  String get statistics => "Statistics";

  @override
  String get settings => "Settings";
  @override
  String get password => "пароль";
  @override
  String get forgotPassword => "забыл пароль";
  @override
  String get signIn => "войти";
  @override
  String get loginError => "пользователь не нашолса";
  @override
  String get confirmPassword => "подтвердить пароль";
  @override
  String get recoverPassword => "восстановления пароля";
  @override
  String get forgotPasswordLarge => "забыл свой пароль?";
  @override
  String get confirmEmail => "подтверди твой электронный адрес и мы Отправим вам инструкцией ";
  @override
  String get send => "поселать";
  @override
  String get emailSent => "мейл послан";
}
