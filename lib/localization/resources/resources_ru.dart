// ================= A Class For Russian Language =================
import 'package:balance_me/localization/resources/resources.dart';

class LanguageRu extends Languages {
  // General
  @override
  String get languageName => "русский";

  @override
  String get languageCode => "ru";

  @override
  String get appName => "балансмена";

  @override
  String get appTitle => "BalanceMe";
  //settings
  @override
  String get settingsTitle => "настройки";

  @override
  String get profileSettings => "профиль";

  @override
  String get groupSettings => "группа";

  @override
  String get passwordSettings => "изменить пароль";

  @override
  String get darkModeSettings => "темный режим";

  @override
  String get endOfMonthSettings => "конец месяца";

  @override
  String get languageSettings => "язык";

  @override
  String get versionSettings => "Версия";

  @override
  String get newPassword => "новый пароль";

  // Login
  @override
  String get welcome => "Добро пожаловать";

  @override
  String get login => "вход";

  @override
  String get logout => "выход";

  @override
  String get successfullyLogout => "удачный выход";

  @override
  String get signUpTitle => "регистрация";

  @override
  String get emailText => "электронный адрес";

  @override
  String get password => "пароль";

  @override
  String get forgotPassword => "забыл пароль";

  @override
  String get signIn => "войти";

  @override
  String get loginError => "пользователь не нашолса";

  @override
  String get nullDetails => "дла окончания регистраций напишите ваш мейл и пароль";

  @override
  String get signUpError => "регистрация провалилась, праверти ваш связь к интернету ";

  @override
  String get confirmPassword => "подтвердить пароль";

  @override
  String get invalidPasswords => "пароли не похоже";

  //password recovery
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

  // Navigation
  @override
  String get balance => "баланс";

  @override
  String get statistics => "статистика";

  @override
  String get settings => "настройки";

  // Charts
  @override
  String get available => "имеющиеся";


}
