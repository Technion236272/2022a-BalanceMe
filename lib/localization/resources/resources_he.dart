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
  String get signUpTitle => "הרשמה‎";

  @override
  String get emailText => "כתובת דואר אלקטרוני‎";

  // Login
  @override
  String get welcome => "‎ברוך הבא";

  @override
  String get login => "‎התחבר";

  @override
  String get logout => "‎התנתק";

  @override
  String get successfullyLogout => "‎התנתקת בהצלחה";

  // Navigation
  @override
  String get balance => "‎המאזן";

  @override
  String get statistics => "‎סטטיסטיקות";

  @override
  String get settings => "‎הגדרות";
  @override
  String get password => "‎סיסמה";

  @override
  String get forgotPassword => "‎שכחת סיסמה?";

  @override
  String get signIn => "‎כניסה";
  @override
  String get loginError => "‎המשתמש לא נמצא";
}
