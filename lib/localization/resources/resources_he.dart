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
  String get balanceInfo =>  "‎כאן תוכל לנהל את ההוצאות וההכנסות שלך";

  @override
  String get toGetStartedInfo =>  "‎כדי להתחיל התחבר או נסה את האפליקציה";

  @override
  String get expenses => "‎הוצאות";

  @override
  String get income => "‎הכנסות";

  @override
  String get target => "‎בפועל";

  @override
  String get expected => "צפוי‎";
}
