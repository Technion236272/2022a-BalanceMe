// ================= An Abstract Class For Language =================
import 'package:flutter/material.dart';

abstract class Languages {

  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  // General
  String get languageName;
  String get languageCode;
  String get strAppName;
  String get strAppTitle;
  String get strEssentialField;
  String get strMaxCharactersLimit;
  String get strMustPositiveNum;
  String get strYes;
  String get strNo;
  String get strDate;

// Settings
  String get strProfile;
  String get strProfileSettings;
  String get strPasswordSettings;
  String get strCurrencySettings;
  String get strEndOfMonthSettings;
  String get strLanguageSettings;
  String get strVersionSettings;
  String get strNewPassword;
  String get strPasswordUpdate;
  String get strFinish;
  String get strFirstName;
  String get strLastName;
  String get strWeakPassword;
  String get strNotSignedIn;
  String get strSignInTimeout;
  String get strChangeLanguageAlertDialogContent;

  // Login
  String get strWelcomeBack;
  String get strWelcomeAboard;
  String get strLogin;
  String get strLogout;
  String get strSuccessfullyLogout;
  String get strSuccessfullyLogin;
  String get strSuccessfullySignUp;
  String get strSignUp;
  String get strEmailText;
  String get strPassword;
  String get strForgotPassword;
  String get strSignIn;
  String get strUserNotFound;
  String get strMissingFields;
  String get strConfirmPassword;
  String get strMismatchingPasswords;
  String get strChangePasswordSuccess;
  String get strProfileUpdateSuccessful;
  String get strNoImagePicked;
  String get strGalleryOption;
  String get strCameraOption;
  String get strMinPasswordLimit;
  String get strBadEmail;
  String get strIncorrectPassword;
  String get strEmailInUse;
  String get strTooManyProviders;
  String get strLinkProviderError;

  // Password Recovery
  String get strRecoverPassword;
  String get strForgotPasswordLink;
  String get strConfirmEmail;
  String get strSend;
  String get strEmailSent;

  // Navigation
  String get strBalance;
  String get strArchive;
  String get strSettings;

  // Charts
  String get strAvailable;

  // Balance
  String get strNothingToShow;
  String get strBalanceInfo;
  String get strToGetStartedInfo;
  String get strExpense;
  String get strExpenses;
  String get strIncome;
  String get strIncomes;
  String get strCurrent;
  String get expected;
  String get amount;
  String get strCategory;
  String get strAddCategory;
  String get strTransaction;
  String get strAddTransaction;
  String get strEditCategory;
  String get strDetailsCategory;
  String get strEditTransaction;
  String get strDetailsTransaction;
  String get strCategoryName;
  String get strTransactionName;
  String get strAddDescription;
  String get strEmptyDescription;
  String get strBack;
  String get strSave;
  String get strSaveSucceeded;
  String get strRemoveSucceeded;
  String get strAlreadyExist;
  String get strDelete;
  String get strVerifyRemoval;

  // Set Category And Transaction
  String get strTypeSelection;
  String get strConstantSwitch;

  // Archive
  String get strDataUnavailable;
  String get strDataReloadSuccessful;

  //About
  String get strAbout;
  String get strLegalese;
  String get strScalesIcon;
}
