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



  @override
  String get signUpTitle => "Sign Up";

  @override
  String get emailText => "Email";

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
  @override
  String get password => "Password";


  @override
  String get forgotPassword => "FORGOT PASSWORD";

  @override
  String get signIn => "SIGN IN";

  @override
  String get loginError => "User not found";
  @override
  String get confirmPassword => "Confirm Password";

  @override
  String get recoverPassword => "Password recovery";
  @override
  String get forgotPasswordLarge => "Forgot your password?";
  @override
  String get confirmEmail => "Confirm your email and we'll send the instructions";
  @override
  String get send => "SEND";

}
