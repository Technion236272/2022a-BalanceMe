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

  @override
  String get essentialField => "this is an essential field";

  @override
  String get maxCharactersLimit => "The maximum number of characters is %";

  @override
  String get mustPositiveNum => "The number must be above 0";

  @override
  String get yes => "Yes";

  @override
  String get no => "No";

  @override
  String get date =>"Date";

  // Settings
  @override
  String get profileSettings => "профиль";

  @override
  String get passwordSettings => "изменить пароль";

  @override
  String get endOfMonthSettings => "конец месяца";

  @override
  String get languageSettings => "язык";

  @override
  String get versionSettings => "Версия";

  @override
  String get newPassword => "новый пароль";

  @override
  String get passwordUpdate => "введите новый пароль для свой юзер";

  @override
  String get finish => "закончить";

  @override
  String get firstName => "имя";

  @override
  String get lastName => "фамилия";

  @override
  String get weakPassword => "ваш пароль слишком слабый, напишите сильны пароль.";

  @override
  String get changePasswordError => "Ошибка при смене пароля. убедитесь, что вы зарегистрированы и вошли в систему, и повторите попытку";

  @override
  String get notSignedIn => "Не обнаружено записаней аккаунт.убедитесь, что вы зарегистрированы и попробуйте снова";

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
  String get confirmPassword => "подтвердить пароль";

  @override
  String get invalidPasswords => "пароли не похоже";

  @override
  String get changePasswordSuccess => "успешно изменен пароль";

  @override
  String get profileChangeSuccessful => "Профиль успешно обновлен";

  @override
  String get noImagePicked => "Вы не выбрали образ. выберите образ, чтобы изменить свой аватар";

  @override
  String get gallery => "галерея";

  @override
  String get camera => "камера";

  @override
  String get minPasswordLimit => "The password should contains at least % characters";

  // Password Recovery
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
  String get nothingToShow => "There is nothing to show here";

  @override
  String get balanceInfo => "Here you can manage your income \n and expenses";

  @override
  String get toGetStartedInfo => "To get started you can login or just \n experience the app";

  @override
  String get expense => "Expense";

  @override
  String get expenses => "Expenses";

  @override
  String get income => "Income";

  @override
  String get incomes => "Incomes";

  @override
  String get current => "Current";

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
  String get detailsCategory => "Category Details";

  @override
  String get editTransaction => "Edit Transaction";

  @override
  String get detailsTransaction => "Transaction Details";

  @override
  String get categoryName => "Category Name";

  @override
  String get transactionName => "Transaction Name";

  @override
  String get addDescription => "Add Description...";

  @override
  String get emptyDescription => "There is no description";

  @override
  String get back => "Back";

  @override
  String get save => "SAVE";

  @override
  String get saveSucceeded => "The % has been saved successfully";

  @override
  String get removeSucceeded => "The % has been removed successfully";

  @override
  String get alreadyExist => "The % is already exist";

  @override
  String get delete => "Delete %";

  @override
  String get verifyRemoval => "Are you sure you want to remove this %?";

  //Add category
  @override
  String get typeSelection => "Type";

  @override
  String get constantSwitch => "Constant";
}
