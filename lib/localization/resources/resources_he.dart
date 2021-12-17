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
  //settings
  @override
  String get settingsTitle => "‎הגדרות";

  @override
  String get profileSettings => "‎פרופיל";

  @override
  String get groupSettings => "קבוצה‎";

  @override
  String get passwordSettings => "שינוי סיסמה‎ ";

  @override
  String get darkModeSettings => "‎מצב כהה";

  @override
  String get endOfMonthSettings => "סוף החודש‎";

  @override
  String get languageSettings => "‎שפה";

  @override
  String get versionSettings => "גרסה‎";

  @override
  String get newPassword => "‎סיסמה חדשה";

  @override
  String get passwordUpdate => "הקלד סיסמה חדשה למשתמש שלך‎";

  @override
  String get finish => "‎סיום";

  @override
  String get firstName => "שם פרטי ‎";

  @override
  String get lastName => "שם משפחה ‎";

  @override
  String get weakPassword => "‎הסיסמה שלך חלשה מדי, רשום סיסמה חזקה יותר";

  @override
  String get changePasswordError => "שינוי הסיסמה נכשל, וודא שנכנסת לחשבונך ונסה שוב ‎";

  @override
  String get notSignedIn => "‎אין חשבון רשום כעת, וודא שנכנסת לחשבונך ונסה שוב";

  @override
  String get groupScreenTitle => "הקבוצה שלי‎ ";

  @override
  String get leaveGroup => "עזיבת קבוצה ‎";

  @override
  String get members => "חברי הקבוצה‎";

  @override
  String get description => "‎תיאור ";

  @override
  String get create => "‎יצירה";

  @override
  String get join => "הצטרפות‎";

  @override
  String get group => "קבוצה‎";

  @override
  String get createGroupInstructions => "ליצירת קבוצה חדשה, בחר שם יחודי‎";

  @override
  String get groupName => "שם הקבוצה ‎";

  @override
  String get descriptionInstruction => "הוספת תיאור...‎";

  @override
  String get changePasswordSuccess => "סיסמה שונתה בהצלחה‎";

  @override
  String get profileChangeSuccessful => "‎הפרופיל עודכן בהצלחה";

  @override
  String get noImagePicked => "‎לא בחרת תמונה, בחר תמונה, כדי לעדכן את האווטאר שלך";

  @override
  String get gallery => "גלריה‎";

  @override
  String get camera => "מצלמה‎";

  // Login
  @override
  String get welcome => "‎ברוכים הבאים";

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
  String get nullDetails => "עליך לרשום מייל וסיסמה אם ברצונך להירשם‎";

  @override
  String get signUpError => "ההרשמה נכשלה, יש לבדוק את החיבור לרשת ולנסות שנית ‎";

  @override
  String get confirmPassword => "אימות סיסמה‎";

  @override
  String get invalidPasswords => "הסיסמאות אינן זהות‎ ";

  //password recovery
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
