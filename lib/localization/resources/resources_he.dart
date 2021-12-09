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
  String get yes => "‎כן";

  @override
  String get no => "‎לא";

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
  String get balanceInfo =>  "‎באפליקציה ניתן לנהל את ההוצאות וההכנסות\n שלך"; //TODO - need to check the view

  @override
  String get toGetStartedInfo =>  "‎כדי להתחיל יש להתחבר או פשוט לנסות את \n האפליקציה"; //TODO - need to check the view

  @override
  String get expense => "‎הוצאה";

  @override
  String get expenses => "‎הוצאות";

  @override
  String get income => "‎הכנסה";

  @override
  String get incomes => "‎הכנסות";

  @override
  String get now => "‎בפועל";

  @override
  String get expected => "צפוי‎";

  @override
  String get amount => "‎כמות";

  @override
  String get category => "‎קטגוריה";

  @override
  String get addCategory => "‎הוספת קטגוריה";

  @override
  String get transaction => "‎תנועה";

  @override
  String get addTransaction => "‎הוספת תנועה";

  @override
  String get editCategory => "‎עריכת קטגוריה";

  @override
  String get editTransaction => "‎עריכת התנועה";

  @override
  String get categoryName => "‎שם הקטגוריה";

  @override
  String get transactionName => "‎שם התנועה";

  @override
  String get addDescription => "‎תיאור...";

  @override
  String get save => "‎שמירה";

  @override
  String get saveSucceeded => "‎ה% נשמרה בהצלחה";

  @override
  String get delete => "‎מחיקת %";

  @override
  String get verifyRemoval => "‎האם למחוק את ה%?";
}
