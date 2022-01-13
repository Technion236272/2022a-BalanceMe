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

  @override
  String get strAdd =>"Add";

  @override
  String get strRemoved =>"removed";

  @override
  String get strChanged =>"changed";

  @override
  String get strSet =>"Set";

  @override
  String get strClose =>"Close";

  @override
  String get strInvite =>"Invite";

  @override
  String get strResend =>"Resend";

  @override
  String get strApprove =>"Approve";

  @override
  String get strReject =>"Reject";

  @override
  String get strProblemOccurred =>"Problem occurred, please try again later";

  @override
  String get strHide =>"Hide";

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
  String get strDarkModeSettings => "Dark Mode";

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
  String get strDarkModeInfo => "The theme the app will display";

  @override
  String get strAboutInfo => "Пакеты и лицензии, используемые приложением";

  @override
  String get strProfileInfo => "Ваш профиль, има и образ";

  @override
  String get strPasswordChangeInfo => "Изменение пароля при входе";

  @override
  String get strConstants => "Постоянные настройки:";

  @override
  String get strInviteFriend => "Invite a friend";

  @override
  String get strInviteFriendInfo => "Click on the button for inviting your friend to enjoy the app";

  @override
  String get strInviteFriendContent => "You are welcome to try a perfect app that will allow you to keep track of your budgets, manage incomes and expenses easily, and compare your spending with previous months with our intuitive archive.\n%";

  @override
  String get strInviteFriendSubject => "Try BalanceMe App";

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
  String get strLanguage => "language";

  @override
  String get strTheme => "theme";

  @override
  String get strBeforeChangeAlertDialogContent => "Attention:\nChange % might reset all your data. For saving the data, please log-in or sign up first.\nAre you sure you want to change the %?";

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
  String get strAddDescription => "Добавить описание... (optional)";

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

  // Summary
  @override
  String get strSummary => "Summary";

  @override
  String get strBalanceSummary => "Monthly Balance Summary";
  //TODO - Translate this please
  @override
  String get strCurrentIncomes => "Current Incomes";

  @override
  String get strExpectedIncomes => "Expected Incomes";

  @override
  String get strCurrentExpenses => "Current Expenses";

  @override
  String get strExpectedExpenses => "Expected Expenses";

  @override
  String get strTotalExpectedBalance => "Total Expected Balance";

  @override
  String get strTotalCurrentBalance => "Total Current Balance";

  @override
  String get strCurrentBankBalance => "Current Bank Balance";

  @override
  String get strExpectedBankBalance => "Expected Bank Balance";

  @override
  String get strBeginningMonthBalance => "Bank balance before";

  @override
  String get strBankInfo => "Current Bank Balance = Bank balance + Total Current Balance \nExpected Bank Balance = Bank balance + Total Expected Balance";

  @override
  String get strBeginningMontBalanceInfo => "This optional field allows you to enter the existing amount in the bank account at the beginning of the month and receive information about the status of the bank account";

  @override
  String get strIncomeBalanceInfo => "All categories current incomes vs expected incomes";

  @override
  String get strExpensesBalanceInfo => "All categories current expenses vs expected expenses";

  @override
  String get strTotalBalanceInfo => "Total Current Balance = Current Incomes - Current Expenses \nTotal Expected Balance = Expected Incomes - Expected Expenses";


  // Workspaces
  @override
  String get strWorkspace => "Workspace";

  @override
  String get strWorkspaceExplanation => "‎מרחב עבודה מאפשר לנהל ולשתף את המאזן החודשי בין מספר משתמשים.\nבעמוד זה ניתן להוסיף מרחב חדש (אם המרחב כבר קיים ניתן לשלוח בקשת הצטרפות למייסד המרחב), להזמין משתמשים למרחב, למחוק מרחב ולהחליף בין מרחבים.";

  @override
  String get strWorkspaceTooltip => "‎כל מרחב עבודה מתפקד כיחידה עצמאית וכל שינוי, הוספה והסרה ישתקף בו ולא ישפיע על מרחבים אחרים. ניתן לפתוח מספר לא מוגבל של מרחבי עבודה ולשתף כל אחד מהם עם מספר לא מוגבל של משתמשים. כל שינוי, הוספה או הסרה של הכנסה או הוצאה במרחב ישתקף אוטומטית אצל כל המשתמשים במרחב. ניתן להשתמש במרחבי העבודה גם לניהול אירוע מיוחד הדורש תכנון ספיציפי בפני עצמו, כגון אירוע משפחתי, טיול ועוד.";

  @override
  String get strChooseWorkspace => "Choose workspace:";

  @override
  String get strAddNewWorkspace => "New workspace name";

  @override
  String get strWorkspaceOperationSuccessful => "The workspace was % successfully";

  @override
  String get strCurrentWorkspace => "Current Workspace";

  @override
  String get strManageWorkspaces => "Manage Workspaces";

  @override
  String get strNotEmailValidator => "This field can't include the character @";

  @override
  String get strWorkspaceAlreadyExist => "You are already a member in this workspace";

  @override
  String get strOtherWorkspaceUsers => "Other users in the workspace:";

  @override
  String get strEmptyWorkspace => "You are alone in this workspace";

  @override
  String get strJoinWorkspace => "This workspace is already exist.\nDo you want to send a joining request to this workspace?";

  @override
  String get strWorkspaceJoinRequestSent => "A joining request to the workspace has been sent";

  @override
  String get strPendingWorkspaceRequests => "Pending joining requests:";

  @override
  String get strJoiningWorkspaceRequestExist => "A joining request to this workspace is already exist";

  @override
  String get strWorkspaceCreated => "The workspace has been created";

  @override
  String get strInviteUserToWorkspace => "Invite user to workspace";

  @override
  String get strUserInvitedToWorkspace => "Good news!\nYou have been invited to join % workspace by #!";

  @override
  String get strUserRequestJoiningToWorkspace => "# requests to join % workspace";

  @override
  String get strUserApproveJoining => "Your application to join % workspace has been approved by #!";

  @override
  String get strUserDisapproveJoining => "Your application to join % workspace has been rejected by #";

  @override
  String get strPendingUsersRequestsTitle => "Those users want to join this workspace:";

  @override
  String get strInvitedSuccessfullyWorkspace => "An invitation to the workspace has been sent";

  @override
  String get strPendingInvitationsRequests => "You have been invited to join:";

  @override
  String get strUserApproveInvitation => "# accepts your invitation to join % workspace";

  @override
  String get strUserRejectInvitation => "# rejects your invitation to join % workspace";

  // Set Category And Transaction
  @override
  String get strTypeSelection => "вид";

  @override
  String get strConstantSwitch => "постоянный";

  @override
  String get strBadNumberForm => "Вставленный текст - это не число";

  @override
  String get strIncomeTransactionInfo => "Income transactions examples: \n Rental payment from... \n Salary from... \n Tax refund from...";

  @override
  String get strExpenseTransactionInfo => "Expense transactions examples:\n Rental payment \n Electricity expenses \n Groceries \n Buying T-shirt in... \n Watching cinema movie";

  @override
  String get strIncomeCategoryInfo => "Income Category examples:\n Rental payments \n Salaries \n Refunds";

  @override
  String get strExpenseCategoryInfo => "Expense Category examples:\n Apartment \n Supermarket \n Shopping \n Hobbies";

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

  // Monthly Report
  @override
  String get strMonthlyReportSubject => "Your Report For Month % Is Here! [Workspace: #]";

  @override
  String get strMonthlyReportContentHeader => "Hurrah! Another month is ended. It is a good time to summarize the month:";

  @override
  String get strMonthlyReportContentFooter => "As usual, the constants transactions for the next month are created.\nSee you next month!";

  @override
  String get strFinalIncomes => "Total incomes";

  @override
  String get strFinalExpenses => "Total expenses";

  @override
  String get strEndOfMonthBankBalance => "Bank balance after";

  @override
  String get strSendMonthlyReport => "Receive monthly report";

  @override
  String get strSendMonthlyReportInfo => "Mark it if you wish to get a monthly report to your email at the end of the month";
}
