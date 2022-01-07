// ================= A Class For Hebrew Language =================
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/global/constants.dart' as gc;

class LanguageHe extends Languages {
  // General
  @override
  String get languageName => "‎עברית";

  @override
  String get languageCode => "he";

  @override
  String get languageDirection => gc.rtl;

  @override
  String get strAppName => "BalanceMe";

  @override
  String get strAppTitle => "BalanceMe";

  @override
  String get strEssentialField => "‎זהו שדה הכרחי";

  @override
  String get strMaxCharactersLimit => "‎מספר התווים המקסימלי הינו %";

  @override
  String get strMustPositiveNum => "‎המספר חייב להיות גדול מ-0";

  @override
  String get strYes => "‎כן";

  @override
  String get strNo => "‎לא";

  @override
  String get strDate =>"‎תאריך";

  // Settings
  @override
  String get strProfile => "‎פרופיל";

  @override
  String get strProfileSettings => "‎הגדרות הפרופיל";

  @override
  String get strPasswordSettings => "שינוי סיסמה‎ ";

  @override
  String get strCurrencySettings => "‎מטבע";

  @override
  String get strEndOfMonthSettings => "סוף החודש‎";

  @override
  String get strLanguageSettings => "‎שפה";

  @override
  String get strVersionSettings => "גירסה‎";

  @override
  String get strNewPassword => "‎סיסמה חדשה";

  @override
  String get strPasswordUpdate => "יש להקליד סיסמה חדשה למשתמש‎";

  @override
  String get strFinish => "‎סיום";

  @override
  String get strFirstName => "שם פרטי‎";

  @override
  String get strLastName => "שם משפחה‎";

  @override
  String get strWeakPassword => "‎הסיסמה חלשה מדי, יש לרשום סיסמה חזקה יותר";

  @override
  String get strNotSignedIn => "שינוי הסיסמה נכשל, יש לנסות שוב‎";

  @override
  String get strSignInTimeout => "‎אין חשבון רשום כעת, יש לנסות שוב";

  @override
  String get strChangeLanguageAlertDialogContent => "‎שימו לב:\nשינוי השפה עלול לגרום לאיפוס המידע. על מנת לשמור את המידע יש להתחבר או להירשם.\nהאם ברצונך להחליף שפה בכל זאת?";

  @override
  String get strEndOfMonthInfo => "זהו היום בו המידע שלך מהמאזן מועבר לארכיון‎";

  @override
  String get strVersionInfo => "הגרסה הנוכחית של האפליקציה‎";

  @override
  String get strCurrencyInfo => "סוג המטבע שישומש למאזן‎";

  @override
  String get strLanguageInfo => "השפה שהאפליקציה תציג‎";

  @override
  String get strAboutInfo => "חבילות ורשיונות בשימוש באפליקציה‎";

  @override
  String get strProfileInfo => "‎הפרופיל שלך, שם ותמונה";

  @override
  String get strPasswordChangeInfo => "‎שינוי הסיסמה להרשמה";

  @override
  String get strConstants => "הגדרות קבועות:‎";
  // Login
  @override
  String get strWelcomeBack => "‎ברוכים השבים!";

  @override
  String get strWelcomeAboard => "‎ברוכים הבאים!";

  @override
  String get strLogin => "‎התחברות";

  @override
  String get strLogout => "‎התנתקות";

  @override
  String get strSuccessfullyLogout => "‎התנתקת בהצלחה";

  @override
  String get strSuccessfullyLogin => "‎התחברת למערכת בהצלחה. קטגוריות כפולות נמחקו";

  @override
  String get strSuccessfullySignUp => "‎נרשמת למערכת בהצלחה. ניתן לגשת לעמוד ההגדרות על מנת לערוך אותן";

  @override
  String get strSignUp => "הרשמה‎";

  @override
  String get strEmailText => "כתובת דואר אלקטרוני‎";

  @override
  String get strPassword => "‎סיסמה";

  @override
  String get strForgotPassword => "‎שכחת סיסמה?";

  @override
  String get strSignIn => "‎כניסה";

  @override
  String get strUserNotFound => "‎המשתמש לא נמצא";

  @override
  String get strMissingFields => "יש לרשום כתובת דואר אלקטרוני וסיסמה במידה וברצונך להירשם‎";

  @override
  String get strMismatchingPasswords => "הסיסמאות אינן זהות‎ ";

  @override
  String get strConfirmPassword => "אימות סיסמה‎";

  @override
  String get strChangePasswordSuccess => "הסיסמה שונתה בהצלחה‎";

  @override
  String get strProfileUpdateSuccessful => "‎הפרופיל עודכן בהצלחה";

  @override
  String get strNoImagePicked => "‎לא נבחרה תמונה";

  @override
  String get strGalleryOption => "גלריה‎";

  @override
  String get strCameraOption => "מצלמה‎";

  @override
  String get strMinPasswordLimit => "‎אורך הסיסמה צריך להיות לפחות % תווים";

  @override
  String get strBadEmail => "‎כתובת הדואר האלקטרוני שהוזנה אינה תקינה";

  @override
  String get strIncorrectPassword => "‎הסיסמה שכתבת אינה תואמת את כתובת הדואר האלקטרונית";

  @override
  String get strEmailInUse => "‎קיים חשבון עם כתובת הדואר האלקטרונית הזו";

  @override
  String get strTooManyProviders => "‎לא ניתן להוסיף חשבון נוסף לכתובת זו";

  @override
  String get strLinkProviderError => "קיים חשבון עם כתובת זו תחת ספק אחר‎";

  // Password Recovery
  @override
  String get strRecoverPassword => "שחזור סיסמה‎";

  @override
  String get strForgotPasswordLink => "שכחת את הסיסמה שלך?‎";

  @override
  String get strConfirmEmail => "יש לאמת את כתובת הדואר האלקטרוני שלך. לאחר מכן ההוראות לשחזור הסיסמה ישלחו‎";

  @override
  String get strSend => "שליחה‎";

  @override
  String get strEmailSent => "‎ההודעה נשלחה";

  // Navigation
  @override
  String get strBalance => "‎המאזן";

  @override
  String get strArchive => "‎ארכיון";

  @override
  String get strSettings => "‎הגדרות";

  // Charts
  @override
  String get strAvailable => "‎זמין";

  // Balance
  @override
  String get strNothingToShow => "‎בינתיים אין מה להציג כאן";

  @override
  String get strBalanceInfo =>  "‎האפליקציה נועדה לניהול ההוצאות וההכנסות החודשיות.";

  @override
  String get strToGetStartedInfo =>  "‎על מנת לשמור את המידע וליהנות מכל יכולות האפליקציה, יש להתחבר.";

  @override
  String get strExpense => "‎הוצאה";

  @override
  String get strExpenses => "‎הוצאות";

  @override
  String get strIncome => "‎הכנסה";

  @override
  String get strIncomes => "‎הכנסות";

  @override
  String get strCurrent => "‎בפועל";

  @override
  String get expected => "צפוי‎";

  @override
  String get amount => "‎כמות";

  @override
  String get strCategory => "‎קטגוריה";

  @override
  String get strAddCategory => "‎הוספת קטגוריה";

  @override
  String get strDetailsCategory => "‎פרטי הקטגוריה";

  @override
  String get strTransaction => "‎תנועה";

  @override
  String get strAddTransaction => "‎הוספת תנועה";

  @override
  String get strEditCategory => "‎עריכת קטגוריה";

  @override
  String get strEditTransaction => "‎עריכת התנועה";

  @override
  String get strDetailsTransaction => "‎פרטי התנועה";

  @override
  String get strCategoryName => "‎שם הקטגוריה";

  @override
  String get strTransactionName => "‎שם התנועה";

  @override
  String get strAddDescription => "‎תיאור...";

  @override
  String get strEmptyDescription => "‎אין תיאור זמין";

  @override
  String get strBack => "‎חזור";

  @override
  String get strSave => "‎שמירה";

  @override
  String get strSaveSucceeded => "‎ה% נשמרה בהצלחה";

  @override
  String get strRemoveSucceeded => "‎ה% הוסר בהצלחה";

  @override
  String get strAlreadyExist => "‎ה-% כבר קיים במערכת";

  @override
  String get strDelete => "‎מחיקת %";

  @override
  String get strVerifyRemoval => "‎האם למחוק את ה%?";

  // Set Category And Transaction
  @override
  String get strTypeSelection => "‎סוג";

  @override
  String get strConstantSwitch => "‎קבוע";

  @override
  String get strBadNumberForm => "‎הטקסט שהוכנס איננו מספר";

  @override
  String get strAttachedImage => "‎תמונה משויכת";

  @override
  String get strUpload => "העלאה‎";

  // Archive
  @override
  String get strDataUnavailable => "‎אין מידע זמין עבור פרק הזמן הנבחר";

  @override
  String get strDataReloadSuccessful => "‎המידע נטען בהצלחה";

  @override
  String get strAbout => "‎אודות האפליקציה";

  @override
  String get strLegalese => "‎כל החבילות והאייקונים בשימוש שייכים לבעליהם";

  @override
  String get strScalesIcon => "‎אייקון מאזניים";
}
