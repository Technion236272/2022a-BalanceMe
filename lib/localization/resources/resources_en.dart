// ================= A Class For English Language =================
import 'package:balance_me/localization/resources/resources.dart';

class LanguageEn extends Languages {
  // General
  @override
  String get languageName => "English";

  @override
  String get languageCode => "en";

  @override
  String get appName => "BalanceMe";

  @override
  String get appTitle => "BalanceMe";

  // Login
  @override
  String get welcome => "Welcome";

  @override
  String get login => "Login";

  @override
  String get logout => "Logout";

  @override
  String get successfullyLogout => "Successfully logged out";
}
