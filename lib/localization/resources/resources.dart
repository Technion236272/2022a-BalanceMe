// ================= An Abstract Class For Language =================
import 'package:flutter/material.dart';

abstract class Languages {

  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  // General
  String get languageName;
  String get languageCode;
  String get appName;
  String get appTitle;
  String get essentialField;
  String get maxCharactersLimit;
  String get mustPositiveNum;
  String get yes;
  String get no;
  String get date;

// Settings
  String get profileSettings;
  String get profilePageTitle;
  String get passwordSettings;
  String get endOfMonthSettings;
  String get languageSettings;
  String get versionSettings;
  String get newPassword;
  String get passwordUpdate;
  String get finish;
  String get firstName;
  String get lastName;
  String get weakPassword;
  String get changePasswordError;
  String get notSignedIn;

  // Login
  String get welcomeBack;
  String get welcomeAboard;
  String get login;
  String get logout;
  String get successfullyLogout;
  String get successfullyLogin;
  String get successfullySignUp;
  String get signUpTitle;
  String get emailText;
  String get password;
  String get forgotPassword;
  String get signIn;
  String get loginError;
  String get nullDetails;
  String get confirmPassword;
  String get invalidPasswords;
  String get changePasswordSuccess;
  String get profileChangeSuccessful;
  String get noImagePicked;
  String get gallery;
  String get camera;
  String get minPasswordLimit;
  String get badEmail;
  String get incorrectPassword;
  String get emailInUse;
  String get tooManyProviders;

  // Password Recovery
  String get recoverPassword;
  String get forgotPasswordLarge;
  String get confirmEmail;
  String get send;
  String get emailSent;

  // Navigation
  String get balance;
  String get archive;
  String get settings;

  // Charts
  String get available;

  // Balance
  String get nothingToShow;
  String get balanceInfo;
  String get toGetStartedInfo;
  String get expense;
  String get expenses;
  String get income;
  String get incomes;
  String get current;
  String get expected;
  String get amount;
  String get category;
  String get addCategory;
  String get transaction;
  String get addTransaction;
  String get editCategory;
  String get detailsCategory;
  String get editTransaction;
  String get detailsTransaction;
  String get categoryName;
  String get transactionName;
  String get addDescription;
  String get emptyDescription;
  String get back;
  String get save;
  String get saveSucceeded;
  String get removeSucceeded;
  String get alreadyExist;
  String get delete;
  String get verifyRemoval;

  // Set Category And Transaction
  String get typeSelection;
  String get constantSwitch;

  // Archive
  String get dataUnavailable;
  String get dateReloadSuccessful;

  //About
  String get about;
  String get legalese;
}
