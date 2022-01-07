// ================= A Class For Russian Language =================
import 'package:balance_me/localization/resources/resources.dart';

class LanguageRu extends Languages {
  // General
  @override
  String get languageName => "русский";

  @override
  String get languageCode => "ru";

  @override
  String get languageDirection => "ltr";

  @override
  String get strAppName => "BalanceMe";

  @override
  String get strAppTitle => "BalanceMe";

  @override
  String get strEssentialField => "это важная текстовое поле";

  @override
  String get strMaxCharactersLimit => "Максимальное число символов: %";

  @override
  String get strMustPositiveNum => "Число должно быть больше 0";

  @override
  String get strYes => "да";

  @override
  String get strNo => "нет";

  @override
  String get strDate =>"дата";

  // Settings
  @override
  String get strProfile => "профиль";

  @override
  String get strProfileSettings => "настройки профиля";

  @override
  String get strPasswordSettings => "изменить пароль";

  @override
  String get strCurrencySettings => "валюта";

  @override
  String get strEndOfMonthSettings => "конец месяца";

  @override
  String get strLanguageSettings => "язык";

  @override
  String get strVersionSettings => "Версия";

  @override
  String get strNewPassword => "новый пароль";

  @override
  String get strPasswordUpdate => "введите новый пароль для свой юзер";

  @override
  String get strFinish => "закончить";

  @override
  String get strFirstName => "имя";

  @override
  String get strLastName => "фамилия";

  @override
  String get strWeakPassword => "ваш пароль слишком слабый, напишите сильны пароль.";

  @override
  String get strNotSignedIn => "Ошибка при смене пароля. убедитесь, что вы зарегистрированы и вошли в систему, и повторите попытку";

  @override
  String get strSignInTimeout => "Не обнаружено записаней аккаунт.убедитесь, что вы зарегистрированы и попробуйте снова";

  @override
  String get strEndOfMonthInfo => "В этот день ваши балансовые данные отправляются в архив";

  @override
  String get strVersionInfo => "версия приложения";

  @override
  String get strCurrencyInfo => "Тип валюты, которая будет использоваться для Вашего баланса";

  @override
  String get strLanguageInfo => "Язык, который будет отображаться приложением";

  @override
  String get strAboutInfo => "Пакеты и лицензии, используемые приложением";

  @override
  String get strProfileInfo => "Ваш профиль, има и образ";

  @override
  String get strPasswordChangeInfo => "Изменение пароля при входе";

  @override
  String get strConstants => "Постоянные настройки:";

  @override
  String get strDeleteProfile => "Удалить образ профиля";

  @override
  String get strDeleteProfileFailed => "Ошибка удаления, так как у вас нет образа профиля";

  @override
  String get strDeleteProfileAlert => "Удалить образ вашего профиля?";

  @override
  String get strUpdate => "обновить";

  // Login
  @override
  String get strWelcomeBack => "с возвращением!";

  @override
  String get strWelcomeAboard => "добро пожаловать!";

  @override
  String get strLogin => "вход";

  @override
  String get strLogout => "выход";

  @override
  String get strSuccessfullyLogout => "удачный выход";

  @override
  String get strSuccessfullyLogin => "Вы успешно вошли в систему. Дубликаты категорий могут быть удалены.";

  @override
  String get strSuccessfullySignUp => "Вы зарегистрировались успешно. Настройки можно изменить на странице настроек";

  @override
  String get strSignUp => "регистрация";

  @override
  String get strEmailText => "электронный адрес";

  @override
  String get strPassword => "пароль";

  @override
  String get strForgotPassword => "забыл пароль";

  @override
  String get strSignIn => "войти";

  @override
  String get strUserNotFound => "пользователь не нашолса";

  @override
  String get strMissingFields => "дла окончания регистраций напишите ваш мейл и пароль";

  @override
  String get strConfirmPassword => "подтвердить пароль";

  @override
  String get strMismatchingPasswords => "пароли не похоже";

  @override
  String get strChangePasswordSuccess => "успешно изменен пароль";

  @override
  String get strProfileUpdateSuccessful => "Профиль успешно обновлен";

  @override
  String get strNoImagePicked => "Вы не выбрали образ. выберите образ, чтобы изменить свой аватар";

  @override
  String get strGalleryOption => "галерея";

  @override
  String get strCameraOption => "камера";

  @override
  String get strMinPasswordLimit => "Пароль должен содержать минимум % символов";

  @override
  String get strBadEmail => "Ваша электронная почта плохо оформлено";

  @override
  String get strIncorrectPassword => "Пароль, который вы вводите, не совпадает с электронным адресом";

  @override
  String get strEmailInUse => "Учётная запись с этим электронным адресом уже существует, выберите другую";

  @override
  String get strTooManyProviders => "Вы не можете иметь больше двух связанных счетов";

  @override
  String get strLinkProviderError => "Учетная запись с этим электронная почта уже существует под другим провайдером";

  @override
  String get strChangeLanguageAlertDialogContent => "внимание:\nизменить язык может сбросить все ваши данные. Для сохранения данных, пожалуйста, войдите или зарегистрируйтесь сначала.\nВы уверены, что хотите изменить язык?";

  // Password Recovery
  @override
  String get strRecoverPassword => "восстановления пароля";

  @override
  String get strForgotPasswordLink => "забыл свой пароль?";

  @override
  String get strConfirmEmail => "подтверди твой электронный адрес и мы Отправим вам инструкцией ";

  @override
  String get strSend => "поселать";

  @override
  String get strEmailSent => "мейл послан";

  // Navigation
  @override
  String get strBalance => "баланс";

  @override
  String get strArchive => "архив";

  @override
  String get strSettings => "настройки";

  // Charts
  @override
  String get strAvailable => "имеющиеся";

  // Balance
  @override
  String get strNothingToShow => "Здесь нечего показывать";

  @override
  String get strBalanceInfo => "Здесь вы можете управлять своими доходами и расходами.";

  @override
  String get strToGetStartedInfo => "Для сохранения данных и полноценной функциональности, пожалуйста, войдите в систему.";

  @override
  String get strExpense => "расход";

  @override
  String get strExpenses => "расходы";

  @override
  String get strIncome => "доход";

  @override
  String get strIncomes => "доходы";

  @override
  String get strCurrent => "настоящея";

  @override
  String get expected => "ожиданная";

  @override
  String get amount => "сумма";

  @override
  String get strCategory => "категория";

  @override
  String get strAddCategory => "Добавить категорию";

  @override
  String get strTransaction => "транзакция";

  @override
  String get strAddTransaction => "Добавить транзакцию";

  @override
  String get strEditCategory => "изменить категорию";

  @override
  String get strDetailsCategory => "детали категории";

  @override
  String get strEditTransaction => "изменить транзакцию";

  @override
  String get strDetailsTransaction => "детали транзакции";

  @override
  String get strCategoryName => "название категории";

  @override
  String get strTransactionName => "название транзакции";

  @override
  String get strAddDescription => "Добавить описание...";

  @override
  String get strEmptyDescription => "Нет никакого описания";

  @override
  String get strBack => "назад";

  @override
  String get strSave => "сохранить";

  @override
  String get strSaveSucceeded => " % успешно сохраняется";

  @override
  String get strRemoveSucceeded => " % успешно удален";

  @override
  String get strAlreadyExist => " % уже существует";

  @override
  String get strDelete => "стереть %";

  @override
  String get strVerifyRemoval => "Вы уверены, что хотите стереть это %?";

  // Set Category And Transaction
  @override
  String get strTypeSelection => "вид";

  @override
  String get strConstantSwitch => "постоянный";

  @override
  String get strBadNumberForm => "Вставленный текст - это не число";

  // Archive
  @override
  String get strDataUnavailable => "нет Данные за выбранный месяц";

  @override
  String get strDataReloadSuccessful => "Данные были успешно перезагружены";

  @override
  String get strAbout => "О приложении";

  @override
  String get strLegalese => "Все используемые пакеты и значки являются свойствами их владельцев";

  @override
  String get strScalesIcon => "Значок Весы";

  @override
  String get strLoadIcon => "значок загрузки";
}
