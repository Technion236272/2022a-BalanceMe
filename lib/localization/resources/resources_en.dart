// ================= A Class For English Language =================
import 'package:balance_me/localization/resources/resources.dart';

class LanguageEn extends Languages {

  // General
  @override
  String get languageName => "English";

  @override
  String get languageCode => "en";

  @override
  String get languageDirection => "ltr";

  @override
  String get strAppName => "BalanceMe";

  @override
  String get strAppTitle => "BalanceMe";

  @override
  String get strEssentialField => "this is an essential field";

  @override
  String get strMaxCharactersLimit => "The maximum number of characters is %";

  @override
  String get strMustPositiveNum => "The number must be above 0";

  @override
  String get strYes => "Yes";

  @override
  String get strNo => "No";

  @override
  String get strDate =>"Date";

  @override
  String get strAdd =>"Add";

  @override
  String get strSet =>"Set";

// Settings
  @override
  String get strProfile => "Profile";

  @override
  String get strProfileSettings => "Profile Settings";

  @override
  String get strPasswordSettings => "Change Password";

  @override
  String get strEndOfMonthSettings => "End of month";

  @override
  String get strCurrencySettings => "Currency";

  @override
  String get strLanguageSettings => "Language";

  @override
  String get strVersionSettings => "Version";

  @override
  String get strNewPassword => "New Password";

  @override
  String get strPasswordUpdate => "Type in a new password for your user";

  @override
  String get strFinish => "FINISH";

  @override
  String get strFirstName => "First name";

  @override
  String get strLastName => "Last name";

  @override
  String get strWeakPassword => "Your password is too weak, type in a stronger password";

  @override
  String get strNotSignedIn => "No signed in account found. make sure you are registered and logged in and try again";

  @override
  String get strSignInTimeout => "Password change failed. sign in and try again";

  @override
  String get strChangeLanguageAlertDialogContent => "Attention:\nchange language might reset all your data. For saving the data, please log-in or sign up first.\nAre you sure you want to change the language?";

// Login
  @override
  String get strWelcomeBack => "Welcome Back!";

  @override
  String get strWelcomeAboard => "Welcome Aboard!";

  @override
  String get strLogin => "Login";

  @override
  String get strLogout => "Logout";

  @override
  String get strSuccessfullyLogout => "Successfully logged out";

  @override
  String get strSuccessfullyLogin => "You logged in successfully. Duplicate categories might be removed.";

  @override
  String get strSuccessfullySignUp => "You signed up successfully. You can edit your settings in settings page";

  @override
  String get strSignUp => "Sign Up";

  @override
  String get strEmailText => "Email";

  @override
  String get strPassword => "Password";

  @override
  String get strForgotPassword => "FORGOT PASSWORD";

  @override
  String get strSignIn => "SIGN IN";

  @override
  String get strUserNotFound => "User not found";

  @override
  String get strMissingFields => "To sign up, you must type in both your email and password";

  @override
  String get strConfirmPassword => "Confirm Password";

  @override
  String get strMismatchingPasswords => "Passwords don't match";

  @override
  String get strChangePasswordSuccess => "Password successfully changed";

  @override
  String get strProfileUpdateSuccessful => "Profile successfully updated";

  @override
  String get strNoImagePicked => "You haven't picked an image. pick an image to change your avatar";

  @override
  String get strGalleryOption => "Gallery";

  @override
  String get strCameraOption => "Camera";

  @override
  String get strMinPasswordLimit => "The password should contain at least % characters";

  @override
  String get strBadEmail => "Your email is badly formed";

  @override
  String get strIncorrectPassword => "The password you typed in doesn't match to your email";

  @override
  String get strEmailInUse => "An account with this email already exists, choose another";

  @override
  String get strTooManyProviders => "You can't link more than two accounts to this email";

  @override
  String get strLinkProviderError => "An account with this email already exists under a different provider";

  // Password Recovery
  @override
  String get strRecoverPassword => "Password recovery";

  @override
  String get strForgotPasswordLink => "Forgot your password?";

  @override
  String get strConfirmEmail => "Confirm your email and we'll send the instructions";

  @override
  String get strSend => "SEND";

  @override
  String get strEmailSent => "Email sent";

  // Navigation
  @override
  String get strBalance => "Balance";

  @override
  String get strArchive => "Archive";

  @override
  String get strSettings => "Settings";

  // Charts
  @override
  String get strAvailable => "Available";

  // Balance
  @override
  String get strNothingToShow => "There is nothing to show here";

  @override
  String get strBalanceInfo => "Here you can manage your income and expenses.";

  @override
  String get strToGetStartedInfo => "For saving your data and enjoying the full functionality, please log-in.";

  @override
  String get strExpense => "Expense";

  @override
  String get strExpenses => "Expenses";

  @override
  String get strIncome => "Income";

  @override
  String get strIncomes => "Incomes";

  @override
  String get strCurrent => "Current";

  @override
  String get expected => "Expected";

  @override
  String get amount => "Amount";

  @override
  String get strCategory => "category";

  @override
  String get strAddCategory => "Add Category";

  @override
  String get strTransaction => "transaction";

  @override
  String get strAddTransaction => "Add Transaction";

  @override
  String get strEditCategory => "Edit Category";

  @override
  String get strDetailsCategory => "Category Details";

  @override
  String get strEditTransaction => "Edit Transaction";

  @override
  String get strDetailsTransaction => "Transaction Details";

  @override
  String get strCategoryName => "Category Name";

  @override
  String get strTransactionName => "Transaction Name";

  @override
  String get strAddDescription => "Add Description...";

  @override
  String get strEmptyDescription => "There is no description";

  @override
  String get strBack => "Back";

  @override
  String get strSave => "SAVE";

  @override
  String get strSaveSucceeded => "The % has been saved successfully";

  @override
  String get strRemoveSucceeded => "The % has been removed successfully";

  @override
  String get strAlreadyExist => "The % already exists";

  @override
  String get strDelete => "Delete %";

  @override
  String get strVerifyRemoval => "Are you sure you want to remove this %?";

  // Summary
  @override
  String get strSummary => "Summary";

  @override
  String get strBalanceSummary => "Monthly Balance Summary";

  // Workspaces
  @override
  String get strWorkspace => "Workspace";

  @override
  String get strWorkspaceExplanation => "some explanation";  // TODO

  @override
  String get strChooseWorkspace => "Choose workspace:";

  @override
  String get strAddNewWorkspace => "New workspace name";

  @override
  String get strWorkspaceAddedSuccessful => "The workspace was added successfully";

  @override
  String get strCurrentWorkspace => "Current Workspace";

  @override
  String get strManageWorkspaces => "Manage Workspaces";

  @override
  String get strNotEmailValidator => "This field can't be in form of an email and can not include the character @";

  // Set Category And Transaction
  @override
  String get strTypeSelection => "Type";

  @override
  String get strConstantSwitch => "Constant";

  @override
  String get strBadNumberForm => "The inserted text is not a number";

  // Archive
  @override
  String get strDataUnavailable => "There is no data for the selected month";

  @override
  String get strDataReloadSuccessful => "The data has reloaded successfully";

  //about
  @override
  String get strAbout => "About the app";

  @override
  String get strLegalese => "All packages and icons used are properties of their respective owners";

  @override
  String get strScalesIcon => "Scales icon";
}
