// ================= A Class For Hebrew Language =================
import 'package:balance_me/localization/resources/resources.dart';

class LanguageHe extends Languages {
  // General
  @override

  //important- LRM- string from right to left
  String get languageName => "‎עברית";

  @override
  String get languageCode => "he";

  @override
  String get appName => "BalanceMe";

  @override
  String get appTitle => "BalanceMe";

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

  // Login
  @override
  String get welcome => "‎ברוך הבא";

  @override
  String get login => "‎התחבר";

  @override
  String get logout => "‎התנתק";

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
  String get signUpError => "ההרשמה נכשלה, בדוק את חיבורך לרשת ונסה שוב ‎";

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
  String get confirmEmail => "אמת את כתובת הדואר האלקטרוני שלך, ונשלח לך את ההוראות לשחזור סיסמה‎";

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

}
