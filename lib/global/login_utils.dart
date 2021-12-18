// ================= login and sign up functions =================
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/sentry_repository.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';

void signInGoogle(BuildContext context, AuthRepository authRepository,
    UserStorage userStorage) async {
  startLoginProcess(context, authRepository.signInGoogle(), true,
      authRepository, userStorage);
}

void signInFacebook(BuildContext context, AuthRepository authRepository,
    UserStorage userStorage) async {
  startLoginProcess(context, authRepository.signInWithFacebook(), true,
      authRepository, userStorage);
}

void signUpGoogle(BuildContext context, AuthRepository authRepository,
    UserStorage userStorage) async {
  startLoginProcess(context, authRepository.signInGoogle(), false,
      authRepository, userStorage);
}

void signUpFacebook(BuildContext context, AuthRepository authRepository,
    UserStorage userStorage) async {
  startLoginProcess(context, authRepository.signInWithFacebook(), false,
      authRepository, userStorage);
}

void emailPasswordSignUp(
    String? email,
    String? password,
    String? confirmPassword,
    BuildContext context,
    AuthRepository authRepository,
    UserStorage userStorage) async {
  if (email == null || password == null || confirmPassword == null) {
    displaySnackBar(context, Languages.of(context)!.nullDetails);
    return;
  }
  startLoginProcess(context, authRepository.signUp(email, password), false,
      authRepository, userStorage);
}

void emailPasswordSignIn(String? email, String? password, BuildContext context,
    AuthRepository authRepository, UserStorage userStorage) async {
  if (email == null || password == null) {
    displaySnackBar(context, Languages.of(context)!.nullDetails);
    return;
  }
  startLoginProcess(context, authRepository.signIn(email, password), true,
      authRepository, userStorage);
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
  } catch (e, stackTrace) {
    SentryMonitor().sendToSentry(e, stackTrace);
    displaySnackBar(context, Languages.of(context)!.loginError);
  }
}

void startLoginProcess(
    BuildContext context,
    Future<bool> loginFunction,
    bool signedInBefore,
    AuthRepository authRepository,
    UserStorage userStorage) async {
  bool signInAttempt = await loginFunction;
  if (signInAttempt) {
    signedInBefore
        ? await userStorage.GET_postLogin()
        : userStorage.SEND_generalInfo();
    User? user = authRepository.user;
    if (user != null) {
      String? email = authRepository.user!.email;
      if (email != null) {
        signedInBefore
            ? GoogleAnalytics.instance.logLogin(email)
            : GoogleAnalytics.instance.logSignUp(email);
      }
    }
    navigateBack(context);
  } else {
    displaySnackBar(context, Languages.of(context)!.loginError);
  }
}
