// ================= A Class For Hebrew Language =================
import 'package:balance_me/localization/resources/resources.dart';

class LanguageHe extends Languages {
  // General
  @override
  String get languageName => "‎עברית";

  @override
  String get languageCode => "he";

  @override
  String get appName => "BalanceMe";

  @override
  String get appTitle => "BalanceMe";

  @override
  String get essentialField => "‎זהו שדה הכרחי";

  @override
  String get maxCharactersLimit => "‎מספר התווים המקסימלי הינו %";

  @override
  String get mustPositiveNum => "‎המספר חייב להיות גדול מ-0";

  @override
  String get yes => "‎כן";

  @override
  String get no => "‎לא";

  @override
  String get date =>"‎תאריך";

  // Settings
  @override
  String get profileSettings => "‎פרופיל";

  @override
  String get passwordSettings => "שינוי סיסמה‎ ";

  @override
  String get endOfMonthSettings => "סוף החודש‎";

  @override
  String get languageSettings => "‎שפה";

  @override
  String get versionSettings => "גירסה‎";

  @override
  String get newPassword => "‎סיסמה חדשה";

  @override
  String get passwordUpdate => "יש להקליד סיסמה חדשה למשתמש‎";

  @override
  String get finish => "‎סיום";

  @override
  String get firstName => "שם פרטי‎";

  @override
  String get lastName => "שם משפחה‎";

  @override
  String get weakPassword => "‎הסיסמה חלשה מדי, יש לרשום סיסמה חזקה יותר";

  @override
  String get changePasswordError => "שינוי הסיסמה נכשל, יש לנסות שוב‎";

  @override
  String get notSignedIn => "‎אין חשבון רשום כעת, יש לנסות שוב";

  // Login
  @override
  String get welcomeBack => "‎ברוכים השבים!";

  @override
  String get welcomeAboard => "‎ברוכים הבאים!";

  @override
  String get login => "‎התחברות";

  @override
  String get logout => "‎התנתקות";

  @override
  String get successfullyLogout => "‎התנתקת בהצלחה";

  @override
  String get signUpTitle => "הרשמה‎";

  @override
  String get emailText => "כתובת דואר אלקטרוני‎";

  @override
  String get password => "‎סיסמה";

  @override
  String get forgotPassword => "‎שכחת סיסמה?";

  @override
  String get signIn => "‎כניסה";

  @override
  String get loginError => "‎המשתמש לא נמצא";

  @override
  String get nullDetails => "יש לרשום כתובת דואר אלקטרוני וסיסמה במידה וברצונך להירשם‎";

  @override
  String get invalidPasswords => "הסיסמאות אינן זהות‎ ";

  @override
  String get confirmPassword => "אימות סיסמה‎";

  @override
  String get changePasswordSuccess => "הסיסמה שונתה בהצלחה‎";

  @override
  String get profileChangeSuccessful => "‎הפרופיל עודכן בהצלחה";

  @override
  String get noImagePicked => "‎לא נבחרה תמונה";

  @override
  String get gallery => "גלריה‎";

  @override
  String get camera => "מצלמה‎";

  @override
  String get minPasswordLimit => "‎אורך הסיסמה צריך להיות לפחות % תווים";

  @override
  String get badEmail => "‎כתובת הדואר האלקטרוני שלך אינה תקינה, ודא שהוספת @ ";

  @override
  String get incorrectPassword => "‎הסיסמה שכתבת אינה תואמת את כתובת הדואר האלקטרונית";

  @override
  String get emailInUse => "‎קיים חשבון עם כתובת דואר אלקטרוני זו, בחר אחרת";

  // Password Recovery
  @override
  String get recoverPassword => "שחזור סיסמה‎";

  @override
  String get forgotPasswordLarge => "שכחת את הסיסמה שלך?‎";

  @override
  String get confirmEmail => "יש לאמת את כתובת הדואר האלקטרוני שלך. לאחר מכן ההוראות לשחזור הסיסמה ישלחו‎";

  @override
  String get send => "שליחה‎";

  @override
  String get emailSent => "‎ההודעה נשלחה";

  // Navigation
  @override
  String get balance => "‎המאזן";

  @override
  String get statistics => "‎סטטיסטיקות";

  @override
  String get settings => "‎הגדרות";

  // Charts
  @override
  String get available => "‎זמין";

  // Balance
  @override
  String get nothingToShow => "‎בינתיים אין מה להציג כאן";

  @override
  String get balanceInfo =>  "‎באפליקציה ניתן לנהל את ההוצאות וההכנסות\n שלך"; //TODO - need to check the view in different screens

  @override
  String get toGetStartedInfo =>  "‎כדי להתחיל יש להתחבר או פשוט לנסות את \n האפליקציה"; //TODO - need to check the view in different screens

  @override
  String get expense => "‎הוצאה";

  @override
  String get expenses => "‎הוצאות";

  @override
  String get income => "‎הכנסה";

  @override
  String get incomes => "‎הכנסות";

  @override
  String get current => "‎בפועל";

  @override
  String get expected => "צפוי‎";

  @override
  String get amount => "‎כמות";

  @override
  String get category => "‎קטגוריה";

  @override
  String get addCategory => "‎הוספת קטגוריה";

  @override
  String get detailsCategory => "‎פרטי הקטגוריה";

  @override
  String get transaction => "‎תנועה";

  @override
  String get addTransaction => "‎הוספת תנועה";

  @override
  String get editCategory => "‎עריכת קטגוריה";

  @override
  String get editTransaction => "‎עריכת התנועה";

  @override
  String get detailsTransaction => "‎פרטי התנועה";

  @override
  String get categoryName => "‎שם הקטגוריה";

  @override
  String get transactionName => "‎שם התנועה";

  @override
  String get addDescription => "‎תיאור...";

  @override
  String get emptyDescription => "‎אין תיאור זמין";

  @override
  String get back => "‎חזור";

  @override
  String get save => "‎שמירה";

  @override
  String get saveSucceeded => "‎ה% נשמרה בהצלחה";

  @override
  String get removeSucceeded => "‎ה% הוסר בהצלחה";

  @override
  String get alreadyExist => "‎ה-% כבר קיים במערכת";

  @override
  String get delete => "‎מחיקת %";

  @override
  String get verifyRemoval => "‎האם למחוק את ה%?";

  //Add category
  @override
  String get typeSelection => "‎סוג";

  @override
  String get constantSwitch => "‎קבוע";
}
