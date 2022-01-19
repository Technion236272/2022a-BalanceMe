// ================= A Class For Russian Language =================
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/global/constants.dart' as gc;

class LanguageRu extends Languages {
  // General
  @override
  String get languageName => "русский";

  @override
  String get languageCode => "ru";

  @override
  String get languageDirection => gc.ltr;

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
  String get strAdd =>"добавить";

  @override
  String get strRemoved =>"стереть";

  @override
  String get strChanged =>"изменилось";

  @override
  String get strSet =>"установить";

  @override
  String get strClose =>"закрыть";

  @override
  String get strInvite =>"пригласить";

  @override
  String get strResend =>"вновь послать";

  @override
  String get strApprove =>"одобрить";

  @override
  String get strReject =>"отвергнуть";

  @override
  String get strProblemOccurred =>"Проблема возникла, попробуйте позже";

  @override
  String get strHide =>"спрятать";

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
  String get strDarkModeSettings => "Темный режим";

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
  String get strFirstNameLabel => "Ввести имя";

  @override
  String get strLastNameLabel => "Ввести фамилию";

  @override
  String get strWeakPassword => "ваш пароль слишком слабый, напишите сильны пароль.";

  @override
  String get strNotSignedIn => "Ошибка при смене пароля. убедитесь, что вы зарегистрированы и вошли в систему, и повторите попытку";

  @override
  String get strSignInTimeout => "Не обнаружено записаней аккаунт.убедитесь, что вы зарегистрированы и попробуйте снова";

  @override
  String get strLanguage => "язык";

  @override
  String get strTheme => "тема";

  @override
  String get strBeforeChangeAlertDialogContent => "внимания:\nИзменить % может сбросить все ваши данные. Для сохранения данных, пожалуйста, войдите или зарегистрируйтесь сначала.\nВы уверены, что хотите изменить %?";

  @override
  String get strEndOfMonthInfo => "В этот день ваши балансовые данные отправляются в архив";

  @override
  String get strConstants => "Постоянные настройки:";

  @override
  String get strInviteFriend => "пригласить друга";

  @override
  String get strInviteFriendContent => "Вы можете попробовать идеальное приложение, которое позволит вам следить за вашими бюджетами, легко управлять доходами и расходами, и сравнить ваши расходы с предыдущими месяцами с нашим интуитивным архивом.\n%";

  @override
  String get strInviteFriendSubject => "Попробуйте приложение BalanceMe";

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
  String get strMinPasswordLimit => "Длина пароля должна быть не меньше %";

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
  String get strSignUpWith => "Записаться с %";

  @override
  String get strLoginWith => "вход с %";

  @override
  String get strGoogle => "гугл";

  @override
  String get strFacebook => "Фейсбук";

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
  String get strAddDescription => "Добавить описание... (факультативный)";

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
  String get strSummary => "резюме";

  @override
  String get strBalanceSummary => "резюме месячный баланс";

  @override
  String get strCurrentIncomes => "текущий доходы";

  @override
  String get strExpectedIncomes => "Ожидаемые доходы";

  @override
  String get strCurrentExpenses => "текущий расходы";

  @override
  String get strExpectedExpenses => "Ожидаемые расходы";

  @override
  String get strTotalExpectedBalance => "общего Ожидаемые";

  @override
  String get strTotalCurrentBalance => "общего текущий";

  @override
  String get strCurrentBankBalance => "текущий банк";

  @override
  String get strExpectedBankBalance => "Ожидаемые банк";

  @override
  String get strBeginningMonthBalance => "Банковский баланс до";

  @override
  String get strBankInfo => "текущий банк = Банковский баланс + общего текущий баланс \Ожидаемые Банковский баланс = Банковский баланс + общего Ожидаемые баланс";

  @override
  String get strBeginningMontBalanceInfo => "Это факультативное поле позволяет Вам ввести существующую сумму на банковский счет в начале месяца и получить информацию о состоянии банковского счета";

  @override
  String get strIncomeBalanceInfo => "Все категории текущих доходов по сравнению с ожидаемыми доходами";

  @override
  String get strExpensesBalanceInfo => "Все категории текущих расходов по сравнению с ожидаемыми расходами";

  @override
  String get strTotalBalanceInfo => "общего текущий баланс = Текущие доходы - текущие расходы \nобщего Ожидаемые баланс = Ожидаемые доходы - Ожидаемые расходы";

  // Workspaces
  @override
  String get strWorkspace => "рабочее пространство";

  @override
  String get strWorkspaceExplanation => "Рабочее пространство позволяет управлять ежемесячным балансом между несколькими пользователями.\nНа этой странице вы можете добавить новое пространство (если оно уже существует, вы можете послать запрос на присоединение к основателю пространства), пригласить пользователей в пространство, удалить пространство и переключить пространства.";

  @override
  String get strWorkspaceTooltip => "Каждое рабочее пространство функционирует как отдельное подразделение, и любые изменения, добавления и удаления будут отражены в нем и не повлияют на другие пространства. Вы можете открыть неограниченное количество рабочих мест и поделиться каждым с неограниченным числом пользователей. Любое изменение, добавление или удаление вставки или отключения в пространстве будет автоматически отображаться всеми пользователями в пространстве. Рабочие места могут также использоваться для управления специальным мероприятием, которое требует особого дизайна само по себе, как, например, семейное событие, поездка и многое другое.";

  @override
  String get strChooseWorkspace => "Выберите рабочее пространство:";

  @override
  String get strAddNewWorkspace => "Новое имя рабочей пространство";

  @override
  String get strWorkspaceOperationSuccessful => "рабочей пространство был % успешно";

  @override
  String get strCurrentWorkspace => "Текущее рабочее пространство";

  @override
  String get strManageWorkspaces => "Управление рабочими пространствами";

  @override
  String get strNotEmailValidator => "Это поле не может включать символ @";

  @override
  String get strWorkspaceAlreadyExist => "вы уже член этого рабочего пространства";

  @override
  String get strUserAlreadyRequestToJoin => "Пользователь уже попросил присоединиться к этому рабочему пространству";

  @override
  String get strYouAlreadyInvitedToJoin => "Вас уже пригласили присоединиться к этому рабочему пространству";

  @override
  String get strUserAlreadyInWorkspace => "Пользователь уже находится в этом рабочем пространстве";

  @override
  String get strOtherWorkspaceUsers => "Другие пользователи в рабочем пространстве:";

  @override
  String get strEmptyWorkspace => "Вы один в этом рабочем пространстве";

  @override
  String get strJoinWorkspace => "Это рабочее пространство уже существует.\nОтправить запрос на присоединение в это рабочее пространство?";

  @override
  String get strWorkspaceJoinRequestSent => "просьба направлена о присоединении к рабочее пространство";

  @override
  String get strPendingWorkspaceRequests => "Вы обратились с просьбой присоединиться:";

  @override
  String get strJoiningWorkspaceRequestExist => "Запрос на присоединение к этому рабочему пространству уже существует";

  @override
  String get strWorkspaceCreated => "Рабочее пространство было создано";

  @override
  String get strInviteUserToWorkspace => "Приглашение пользователя в рабочее пространство";

  @override
  String get strUserInvitedToWorkspace => "хорошие новости!\nВас пригласили присоединиться % рабочего пространства #!";

  @override
  String get strUserRequestJoiningToWorkspace => "# запросы на присоединение % рабочего пространства";

  @override
  String get strUserApproveJoining => "Ваша заявка на присоединение % рабочего пространства одобрена #!";

  @override
  String get strUserDisapproveJoining => "Ваше заявление на присоединение % рабочего пространства было отклонено #";

  @override
  String get strPendingUsersRequestsTitle => 'Те пользователи, которые хотят присоединиться "%":';

  @override
  String get strInvitedSuccessfullyWorkspace => "Направлено приглашение на рабочие места";

  @override
  String get strPendingInvitationsRequests => "Вас пригласили присоединиться:";

  @override
  String get strUserApproveInvitation => "# принимает ваше приглашение присоединиться % рабочего пространства";

  @override
  String get strUserRejectInvitation => "# отклоняет ваше приглашение присоединиться % рабочего пространства";

  @override
  String get strCantRemovePersonalWorkspace => "Вы не можете удалить свое личное рабочее место";

  @override
  String get strCantInviteSinceUserNotUpdated => "Приглашение не может быть отправлено, так как приглашенный пользователь должен обновить свое приложение";

  // Set Category And Transaction
  @override
  String get strTypeSelection => "вид";

  @override
  String get strConstantSwitch => "постоянный";

  @override
  String get strBadNumberForm => "Вставленный текст - это не число";

  @override
  String get strIncomeTransactionInfo => "Примеры операций с доходами: \n Арендная плата от... \n зарплату от... \n Возврат налогов с...";

  @override
  String get strExpenseTransactionInfo => "Примеры сделок с расходами:\n арендная плата \n Расходы на электричество \n продукты \n Покупка футболки в... \n Просмотр кино";

  @override
  String get strIncomeCategoryInfo => "Примеры по категориям доходов:\n арендные платежи \n оклады \n возмещений";

  @override
  String get strExpenseCategoryInfo => "Примеры по категориям расходов:\n квартира \n супермаркет \n по магазинам \n увлечения";

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

  @override
  String get strLostConnectionImage => "Образ потерянного связь";

  // Monthly Report
  @override
  String get strMonthlyReportSubject => "Ваш отчет за месяц %!";

  @override
  String get strMonthlyReportContentHeader => "Ура! Закончился еще один месяц. Самое время резюмировать месяц:";

  @override
  String get strMonthlyReportContentFooter => "Как обычно, создаются постоянные транзакции на следующий месяц.\nУвидимся в следующем месяце!";

  @override
  String get strFinalIncomes => "всех доходов";

  @override
  String get strFinalExpenses => "общие расходы";

  @override
  String get strEndOfMonthBankBalance => "Банковский баланс после";

  @override
  String get strSendMonthlyReport => "Получать ежемесячный отчет";

  @override
  String get strSendMonthlyReportInfo => "Отметьте это, если вы хотите получить ежемесячный отчет по электронной почте в конце месяца";

  // RateUs
  @override
  String get strRateUs => "Оценить нас";

  @override
  String get strRateUsExplanation => "Нажмите звезду, чтобы задать ваш рейтинг. Добавьте описание здесь, если хотите";

  @override
  String get strSubmit => "отправить";

  @override
  String get strCommentHint => "Задать комментарий здесь (необязательно)";

  @override
  String get strRateRecorded => "Ваш отзыв был записан, спасибо!";

  // Walkthrough
  @override
  String get strWatchWalkthrough => "Смотреть на проход";

  @override
  String get strSkip => "пропустить";

  @override
  String get strNext => "следующий";

  @override
  String get strWalkthroughDescription => "Этот проход покажет вам основные функции приложения.";

  @override
  String get strWalkthroughWelcomeTitle => "Экран входа";

  @override
  String get strWalkthroughWelcomeDescription => "מסך זה מאפשר לחוות את השימוש באפליקציה ללא צורך בהתחברות. ניתן לבצע פעולות, אך על מנת לשמור את המידע שהוכנס יש להירשם או להתחבר לאפליקציה דרך הלחצן בחלקו העליון של המסך.";

  @override
  String get strWalkthroughLoginTitle => "מסך ההתחברות‎";

  @override
  String get strWalkthroughLoginDescription => "דרך מסך זה ניתן להירשם ולהתחבר לאפליקציה. לשם כך, בחרו בלשונית הרלוונטית עבורכם. ניתן להירשם ולהתחבר דרך גוגל, פייסבוק, או דרך שם משתמש וסיסמה לבחירתכם.‎";

  @override
  String get strWalkthroughSummaryDescription => "מסך זה כולל שלוש לשוניות מרכזיות לניהול המאזן החודשי. הלשונית הראשונה היא לשונית הסיכום המאפשרת השוואה בין ההוצאות להכנסות בחודש הנוכחי. בנוסף, בלחיצה כל הכפתור ״שנה״ ניתן לנהל את מרחבי העבודה (יוסבר בהמשך). ניתן (ולא חובה) להכניס את המאזן בחשבון הבנק בתחילת החודש על מנת לקבל את תמונת החשבון בסוף החודש. בכל סוף חודש יתבצע עדכון אוטומטי של המאזן.‎";

  @override
  String get strWalkthroughBalanceTitle => "מסכי ההוצאות וההכנסות‎";

  @override
  String get strWalkthroughBalanceDescription => "הלשוניות הבאות דומות זו לזו וכוללות את ההוצאות וההכנסות לחודש הנוכחי. בכל מסך ניתן לראות בצורה ויזואלית את ההוצאות/ההכנסות ופירוט של קטגוריות ובתוכן תנועות (יוסבר בהמשך). בכפתור הוספת הקטגוריה ניתן להוסיף למסך קטגוריה חדשה. בכפתור ה+ ניתן להוסיף תנועה חדשה. ניתן בעתיד לערוך ולמחוק קטגוריות ותנועות.‎";

  @override
  String get strWalkthroughAddCategoryDescription => "במסך זה ניתן להוסיף קטגוריה כהוצאה/הכנסה. קטגוריה היא שם כולל לקבוצת הוצאות/הכנסות בעלות מכנה משותף. לדוגמה, תחת הקטגוריה של בילויים ניתן להכניס צפייה בסרט או אכילה במסעדה. תוכלו לקבוע בעצמכם את הקטגוריות בהן תשתמשו (במידה ותזדקקו לעזרה, תוכלו ללחוץ לחיצה ארוכה על כפתור סימן הקריאה ליד שם הקטגוריה). יש לקבוע את סך ההוצאות/ההכנסות המוקצבות לקטגוריה.‎";

  @override
  String get strWalkthroughAddTransactionDescription => "במסך זה ניתן להוסיף תנועה חדשה תחת קטגוריה מסוימת. תנועה היא הוצאה/הכנסה ספציפית תחת קטגוריה מסוימת. למשל, תחת קטגוריית הבילויים תוכלו להכניס תנועה בשם צפייה בסרט. על התנועה לכלול את הסכום שהוצא/הוכנס וכן ניתן לקבוע האם התנועה קבועה לכל החודשים. בסוף כל חודש יתרחש ניקוי אוטומטי ותנועות קבועות ימשיכו איתכם לחודש הבא.‎";

  @override
  String get strWalkthroughArchiveDescription => "מסך זה מאפשר צפייה בנתונים מחודשים קודמים. בכל 10 לחודש מתבצע ניקוי של מסכי ההוצאות וההכנסות והנתונים מועברים למסך הארכיון. לחצו את הכפתור במטרה לבחור חודש בו תרצו לצפות.‎";

  @override
  String get strWalkthroughSettingsDescription => "מסך זה מחולק לשני חלקים. החלק העליון כולל הגדרות הניתנות לשינוי, כמו למשל שפה וצבעי האפליקציה. כמו כן, ניתן לקבוע האם לקבל בסוףף כל חודש דו״ח סיכום לדואר האלקטרוני. בחלק התחתון של העמוד ישנן הגדרות קבועות הכוללות אפשרויות להזמנת חבר לאפליקציה, דירוג האפליקציה ואף צפייה חוזרת במדריך זה.‎";

  @override
  String get strWalkthroughFinalTitle => "קדימה לעבודה!‎";

  @override
  String get strWalkthroughFinalDescription => "אנו מזמינים אתכם לחוות ולנהל את המאזן החודשי שלכם באפליקציה. נשמח לשמוע את דעתכם, הצעותיכם וחוויותיכם דרך ״דרגו אותנו״ במסך ההגדרות‎";
}
