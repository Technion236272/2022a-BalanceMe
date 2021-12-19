// ================= Login and SignUp Functions =================
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

void signInGoogle(BuildContext context, AuthRepository authRepository,
    UserStorage userStorage) async {
  startLoginProcess(context, authRepository.signInGoogle(), LoginMethod.Google.toCleanString(), true, userStorage);
}

void signInFacebook(BuildContext context, AuthRepository authRepository, UserStorage userStorage) async {
  startLoginProcess(context, authRepository.signInWithFacebook(), LoginMethod.Facebook.toCleanString(), true, userStorage);
}

void signUpGoogle(BuildContext context, AuthRepository authRepository, UserStorage userStorage) async {
  startLoginProcess(context, authRepository.signInGoogle(), LoginMethod.Google.toCleanString(), false, userStorage);
}

void signUpFacebook(BuildContext context, AuthRepository authRepository, UserStorage userStorage) async {
  startLoginProcess(context, authRepository.signInWithFacebook(), LoginMethod.Facebook.toCleanString(), false, userStorage);
}

void emailPasswordSignUp(String? email, String? password, String? confirmPassword, BuildContext context, AuthRepository authRepository, UserStorage userStorage) async {
  if (email == null || password == null || confirmPassword == null) {
    displaySnackBar(context, Languages.of(context)!.nullDetails);
    return;
  }
  startLoginProcess(context, authRepository.signUp(email, password), LoginMethod.Regular.toCleanString(), false, userStorage);
}

void emailPasswordSignIn(String? email, String? password, BuildContext context,
    AuthRepository authRepository, UserStorage userStorage) async {
  if (email == null || password == null) {
    displaySnackBar(context, Languages.of(context)!.nullDetails);
    return;
  }
  startLoginProcess(context, authRepository.signIn(email, password), LoginMethod.Regular.toCleanString(), true, userStorage);
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

void startLoginProcess(BuildContext context, Future<bool> loginFunction, String loginFunctionName, bool isSigningIn, UserStorage userStorage) async {
  BalanceModel lastBalance = userStorage.balance.copy();
  if (await loginFunction) {

    Future.delayed(const Duration(milliseconds: 10), () async {
      if (isSigningIn) {
        await userStorage.GET_postLogin();
        await userStorage.GET_balanceModelAfterLogin(lastBalance, true);
        GoogleAnalytics.instance.logLogin(loginFunctionName);
      } else {
        userStorage.SEND_generalInfo();
        await userStorage.GET_balanceModelAfterLogin(lastBalance, false);
        GoogleAnalytics.instance.logSignUp(loginFunctionName);
      }

      navigateBack(context);
    });

  } else {
    displaySnackBar(context, Languages.of(context)!.loginError);
  }
}
