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
}
