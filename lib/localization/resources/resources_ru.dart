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

  @override
  String get groupScreenTitle => "моя група";

  @override
  String get leaveGroup => "покинуть группу";

  @override
  String get members => "члены группы";

  @override
  String get description => "описание";

  @override
  String get create => "создания";

  @override
  String get join => "присоединиться ";

  @override
  String get group => "группы";

  @override
  String get createGroupInstructions => "для создания новой группы, выбираете уникальное имя";

  @override
  String get groupName => "имя группы";

  @override
  String get descriptionInstruction => "добавьте описание...";

  @override
  String get changePasswordSuccess => "успешно изменен пароль";

  @override
  String get profileChangeSuccessful => "Профиль успешно обновлен";

  @override
  String get noImagePicked => "Вы не выбрали образ. выберите образ, чтобы изменить свой аватар";

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
