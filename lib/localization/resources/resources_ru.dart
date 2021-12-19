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
  String get maxCharactersLimit => "Максимальное число символов: %";

  @override
  String get mustPositiveNum => "Число должно быть больше 0";

  @override
  String get yes => "да";

  @override
  String get no => "нет";

  @override
  String get date =>"дата";

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
  String get welcomeBack => "Welcome Back!";

  @override
  String get welcomeAboard => "Welcome Aboard!";

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

  @override
  String get badEmail => "Ваш электронний адрес плохо оформлено, убедитесь, что у вас есть @";

  @override
  String get incorrectPassword => "Пароль, который вы вводите, не совпадает с электронным адресом";

  @override
  String get emailInUse => "Учётная запись с этим электронным адресом уже существует, выберите другую";

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
  String get archive => "Archive";

  @override
  String get settings => "настройки";

  // Charts
  @override
  String get available => "имеющиеся";

  // Balance
  @override
  String get nothingToShow => "Здесь нечего показывать";

  @override
  String get balanceInfo => "Здесь вы можете управлять своими доходами \n и расходами";

  @override
  String get toGetStartedInfo => "Для начала вы можете войти или просто \n испытать приложение";

  @override
  String get expense => "расход";

  @override
  String get expenses => "расходы";

  @override
  String get income => "доход";

  @override
  String get incomes => "доходы";

  @override
  String get current => "настоящея";

  @override
  String get expected => "ожиданная";

  @override
  String get amount => "сумма";

  @override
  String get category => "категория";

  @override
  String get addCategory => "Добавить категорию";

  @override
  String get transaction => "транзакция";

  @override
  String get addTransaction => "Добавить транзакцию";

  @override
  String get editCategory => "изменить категорию";

  @override
  String get detailsCategory => "детали категории";

  @override
  String get editTransaction => "изменить транзакцию";

  @override
  String get detailsTransaction => "детали транзакции";

  @override
  String get categoryName => "название категории";

  @override
  String get transactionName => "название транзакции";

  @override
  String get addDescription => "Добавить описание...";

  @override
  String get emptyDescription => "Нет никакого описания";

  @override
  String get back => "назад";

  @override
  String get save => "сохранить";

  @override
  String get saveSucceeded => " % успешно сохраняется";

  @override
  String get removeSucceeded => " % успешно удален";

  @override
  String get alreadyExist => " % уже существует";

  @override
  String get delete => "стереть %";

  @override
  String get verifyRemoval => "Вы уверены, что хотите стереть это %?";

  // Set Category And Transaction
  @override
  String get typeSelection => "вид";

  @override
  String get constantSwitch => "постоянный";

  // Archive
  @override
  String get noDataForRange => "There is no data for the\nselected range";
}
