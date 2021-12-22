// ================= Login and SignUp Functions =================
import 'package:balance_me/pages/profile_settings.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/sentry_repository.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/common_models/balance_model.dart';
import 'package:balance_me/global/types.dart';

void signInGoogle(BuildContext context, AuthRepository authRepository,UserStorage userStorage, {VoidCallback? failureCallback}) async {
  startLoginProcess(context, authRepository.signInGoogle(), LoginMethod.Google.toCleanString(), true, userStorage, failureCallback: failureCallback,authRepository: authRepository);
}

void signInFacebook(BuildContext context, AuthRepository authRepository, UserStorage userStorage, {VoidCallback? failureCallback}) async {
  startLoginProcess(context, authRepository.signInWithFacebook(), LoginMethod.Facebook.toCleanString(), true, userStorage, failureCallback: failureCallback,authRepository: authRepository);
}

void signUpGoogle(BuildContext context, AuthRepository authRepository, UserStorage userStorage, {VoidCallback? failureCallback}) async {
  startLoginProcess(context, authRepository.signInGoogle(), LoginMethod.Google.toCleanString(), false, userStorage, failureCallback: failureCallback,authRepository: authRepository);
}

void signUpFacebook(BuildContext context, AuthRepository authRepository, UserStorage userStorage, {VoidCallback? failureCallback}) async {
  startLoginProcess(context, authRepository.signInWithFacebook(), LoginMethod.Facebook.toCleanString(), false, userStorage, failureCallback: failureCallback,authRepository: authRepository);
}

void emailPasswordSignUp(String? email, String? password, String? confirmPassword, BuildContext context, AuthRepository authRepository, UserStorage userStorage, {VoidCallback? failureCallback}) async {
  if (email == null || password == null || confirmPassword == null) {
    displaySnackBar(context, Languages.of(context)!.nullDetails);
    return;
  }
  startLoginProcess(context, authRepository.signUp(email, password, context), LoginMethod.Regular.toCleanString(), false, userStorage, failureCallback: failureCallback,authRepository: authRepository);
}

void emailPasswordSignIn(String? email, String? password, BuildContext context, AuthRepository authRepository, UserStorage userStorage, {VoidCallback? failureCallback}) async {
  if (email == null || password == null) {
    displaySnackBar(context, Languages.of(context)!.nullDetails);
    return;
  }
  startLoginProcess(context, authRepository.signIn(email, password, context), LoginMethod.Regular.toCleanString(), true, userStorage, failureCallback: failureCallback,authRepository: authRepository);
}

void recoverPassword(String? email, BuildContext context) async {
  if (email == null) {
    displaySnackBar(context, Languages.of(context)!.loginError);
    return;
  }

  FirebaseAuth recover = FirebaseAuth.instance;

  try {
    await recover.sendPasswordResetEmail(email: email);
    navigateBack(context);
    displaySnackBar(context, Languages.of(context)!.emailSent);
    GoogleAnalytics.instance.logRecoverPassword();

  } catch (e, stackTrace) {
    SentryMonitor().sendToSentry(e, stackTrace);
    displaySnackBar(context, Languages.of(context)!.loginError);
  }
}

void startLoginProcess(BuildContext context, Future<bool> loginFunction,
    String loginFunctionName, bool isSigningIn, UserStorage userStorage,
    {VoidCallback? failureCallback,
    required AuthRepository authRepository}) async {
  bool isPressed=false;
  BalanceModel lastBalance = userStorage.balance.copy();
  if (await loginFunction) {
    Future.delayed(const Duration(milliseconds: 10), () async {
      if (isSigningIn) {
        await userStorage.GET_postLogin(context);
        await userStorage.GET_balanceModelAfterLogin(lastBalance, true);
        GoogleAnalytics.instance.logLogin(loginFunctionName);
      } else {
        userStorage.SEND_generalInfo();
        await userStorage.GET_balanceModelAfterLogin(lastBalance, false);
        GoogleAnalytics.instance.logSignUp(loginFunctionName);
      }
      isPressed= directToSettings(context, authRepository, userStorage);

    });
  } else if (failureCallback != null) {
    failureCallback();
  }
  if(!isPressed)
    {
      navigateBack(context);
    }
}
bool directToSettings(BuildContext context, AuthRepository authRepository,
    UserStorage userStorage) {
  bool isPressed=false;
  displaySnackBar(context, Languages.of(context)!.settingsRedirect,
      action: SnackBarAction(
          label: Languages.of(context)!.goSettings,
          onPressed: () {
            _navigateToProfile(context, authRepository, userStorage);
            isPressed=true;
          }));
  return isPressed;
}

void _navigateToProfile(BuildContext context, AuthRepository authRepository,
    UserStorage userStorage) {
  navigateToPage(
      context,
      ProfileSettings(authRepository: authRepository, userStorage: userStorage),
      AppPages.Profile);
}
