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

  // Navigation
  @override
  String get balance => "Balance";

  @override
  String get statistics => "Statistics";

  @override
  String get settings => "Settings";

  // Charts
  @override
  String get available => "Available";

  // Balance
  @override
  String get balanceInfo => "Here you can manage your income and expenses";

  @override
  String get toGetStartedInfo => "To get started you can login or just experience the app";

  @override
  String get expenses => "Expenses";

  @override
  String get income => "Income";

  @override
  String get target => "Target";

  @override
  String get expected => "Expected";
}
