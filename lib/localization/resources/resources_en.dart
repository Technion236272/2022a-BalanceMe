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
  String get essentialField => "this is an essential field";

  @override
  String get yes => "Yes";

  @override
  String get no => "No";

// Login
  @override
  String get welcome => "Welcome";

  @override
  String get login => "Login";

  @override
  String get logout => "Logout";

  @override
  String get successfullyLogout => "Successfully logged out";

  @override
  String get signUpTitle => "Sign Up";

  @override
  String get emailText => "Email";

  @override
  String get password => "Password";

  @override
  String get forgotPassword => "FORGOT PASSWORD";

  @override
  String get signIn => "SIGN IN";

  @override
  String get loginError => "User not found";

  @override
  String get nullDetails => "To sign up, you must type both your email and password ";

  @override
  String get signUpError => "sign up failed, check your connection and try again";

  @override
  String get confirmPassword => "Confirm Password";

  @override
  String get invalidPasswords => "Passwords don't match ";

  //password recovery
  @override
  String get recoverPassword => "Password recovery";

  @override
  String get forgotPasswordLarge => "Forgot your password?";

  @override
  String get confirmEmail => "Confirm your email and we'll send the instructions";

  @override
  String get send => "SEND";

  @override
  String get emailSent => "Email sent";

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
  String get balanceInfo => "Here you can manage your income \nand expenses";

  @override
  String get toGetStartedInfo => "To get started you can login or just \nexperience the app";

  @override
  String get expense => "Expense";

  @override
  String get expenses => "Expenses";

  @override
  String get income => "Income";

  @override
  String get incomes => "Incomes";

  @override
  String get now => "Now";

  @override
  String get expected => "Expected";

  @override
  String get amount => "Amount";

  @override
  String get category => "category";

  @override
  String get addCategory => "Add Category";

  @override
  String get transaction => "transaction";

  @override
  String get addTransaction => "Add Transaction";

  @override
  String get editCategory => "Edit Category";

  @override
  String get editTransaction => "Edit Transaction";

  @override
  String get categoryName => "Category Name";

  @override
  String get transactionName => "Transaction Name";

  @override
  String get addDescription => "Add Description...";

  @override
  String get save => "SAVE";

  @override
  String get saveSucceeded => "The % saved successfully";

  @override
  String get delete => "delete %";

  @override
  String get verifyRemoval => "Are you sure you want to remove this %?";
}
