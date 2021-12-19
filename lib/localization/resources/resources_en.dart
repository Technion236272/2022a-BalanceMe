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
  String get maxCharactersLimit => "The maximum number of characters is %";

  @override
  String get mustPositiveNum => "The number must be above 0";

  @override
  String get yes => "Yes";

  @override
  String get no => "No";

  @override
  String get date =>"Date";

// Settings
  @override
  String get profileSettings => "Profile";

  @override
  String get passwordSettings => "Change Password";

  @override
  String get endOfMonthSettings => "End of month";

  @override
  String get languageSettings => "Language";

  @override
  String get versionSettings => "Version";

  @override
  String get newPassword => "New Password";

  @override
  String get passwordUpdate => "Type in a new password for your user";

  @override
  String get finish => "FINISH";

  @override
  String get firstName => "First name";

  @override
  String get lastName => "Last name";

  @override
  String get weakPassword => "Your password is too weak, type in a stronger password";

  @override
  String get changePasswordError => "No signed in account detected. make sure you are registered and logged in and try again";

  @override
  String get notSignedIn => "Changing password failed. sign in and try again";

// Login
  @override
  String get welcomeBack => "Welcome Back!";

  @override
  String get welcomeAboard => "Welcome Aboard!";

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
  String get nullDetails => "To sign up, you must type both your email and password";

  @override
  String get confirmPassword => "Confirm Password";

  @override
  String get invalidPasswords => "Passwords don't match";

  @override
  String get changePasswordSuccess => "Password successfully changed";

  @override
  String get profileChangeSuccessful => "Profile successfully updated";

  @override
  String get noImagePicked => "You haven't picked an image. pick an image to change your avatar";

  @override
  String get gallery => "Gallery";

  @override
  String get camera => "Camera";

  @override
  String get minPasswordLimit => "The password should contains at least % characters";

  @override
  String get badEmail => "Your email is badly formed, make sure you have a @";

  @override
  String get incorrectPassword => "The password you type in doesn't match to your email";

  @override
  String get emailInUse => "An account with that email already exists, choose another";

  // Password Recovery
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
  String get archive => "Archive";

  @override
  String get settings => "Settings";

  // Charts
  @override
  String get available => "Available";

  // Balance
  @override
  String get nothingToShow => "There is nothing to show here";

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
  String get current => "Current";

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
  String get detailsCategory => "Category Details";

  @override
  String get editTransaction => "Edit Transaction";

  @override
  String get detailsTransaction => "Transaction Details";

  @override
  String get categoryName => "Category Name";

  @override
  String get transactionName => "Transaction Name";

  @override
  String get addDescription => "Add Description...";

  @override
  String get emptyDescription => "There is no description";

  @override
  String get back => "Back";

  @override
  String get save => "SAVE";

  @override
  String get saveSucceeded => "The % has been saved successfully";

  @override
  String get removeSucceeded => "The % has been removed successfully";

  @override
  String get alreadyExist => "The % already exists";

  @override
  String get delete => "Delete %";

  @override
  String get verifyRemoval => "Are you sure you want to remove this %?";

  // Set Category And Transaction
  @override
  String get typeSelection => "Type";

  @override
  String get constantSwitch => "Constant";

  // Archive
  @override
  String get noDataForRange => "There is no data for the selected range";
}
