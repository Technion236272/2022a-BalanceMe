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
  String get essentialField => "this is an essential field";

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

  // Balance
  @override
  String get balanceInfo => "Here you can manage your income \n and expenses";

  @override
  String get toGetStartedInfo => "To get started you can login or just \n experience the app";

  @override
  String get expenses => "Expenses";

  @override
  String get income => "Income";

  @override
  String get now => "Target";

  @override
  String get expected => "Expected";

  @override
  String get amount => "Amount";

  @override
  String get category => "category";

  @override
  String get addCategory => "Add Category";

  @override
  String get transaction => "transaction";

  @override
  String get addTransaction => "Add Transaction";

  @override
  String get editCategory => "Edit Category";

  @override
  String get editTransaction => "Edit Transaction";

  @override
  String get categoryName => "Category Name";

  @override
  String get transactionName => "Transaction Name";

  @override
  String get addDescription => "Add Description...";

  @override
  String get save => "SAVE";

  @override
  String get saveSucceeded => "The % saved successfully";
}
