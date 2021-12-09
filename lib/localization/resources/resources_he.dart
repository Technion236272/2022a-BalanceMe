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

  // Balance
  @override
  String get balanceInfo =>  "‎כאן תוכל לנהל את ההוצאות וההכנסות\n שלך"; //TODO - need to check the view

  @override
  String get toGetStartedInfo =>  "‎כדי להתחיל התחבר או נסה את \n האפליקציה"; //TODO - need to check the view

  @override
  String get expenses => "‎הוצאות";

  @override
  String get income => "‎הכנסות";

  @override
  String get now => "‎בפועל";

  @override
  String get expected => "צפוי‎";

  @override
  String get addCategory => "‎הוספת קטגוריה";

  @override
  String get editCategory => "‎עריכת קטגוריה";

  @override
  String get categoryName => "‎שם הקטגוריה";

  @override
  String get addDescription => "‎הוסף תיאור...";

  @override
  String get save => "‎שמור";
}
