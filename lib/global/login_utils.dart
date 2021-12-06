import 'package:balance_me/common_models/user_model.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart' as auth;
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/global/constants.dart' as gc;

void signInGoogle(BuildContext context) async {
  startLoginProcess(
      context, auth.AuthRepository.instance().signInGoogle(), true);
}

void signInFacebook(BuildContext context) async {
  startLoginProcess(
      context, auth.AuthRepository.instance().signInWithFacebook(), true);
}

void signUpGoogle(BuildContext context) async {
  startLoginProcess(
      context, auth.AuthRepository.instance().signInGoogle(), false);
}

void signUpFacebook(BuildContext context) async {
  startLoginProcess(
      context, auth.AuthRepository.instance().signInWithFacebook(), false);
}

void emailPasswordSignUp(String? email, String? password,
    String? confirmPassword, BuildContext context) async {
  if (email == null || password == null || confirmPassword == null) {
    displaySnackBar(context, Languages.of(context)!.nullDetails);
    return;
  }
  startLoginProcess(
      context, auth.AuthRepository.instance().signUp(email, password), false);
}

void emailPasswordSignIn(
    String? email, String? password, BuildContext context) async {
  if (email == null || password == null) {
    displaySnackBar(context, Languages.of(context)!.nullDetails);
    return;
  }
  startLoginProcess(
      context, auth.AuthRepository.instance().signIn(email, password), true);
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
  } catch (e) {
    displaySnackBar(context, Languages.of(context)!.loginError);
  }
}

void startLoginProcess(BuildContext context, Future<bool> loginFunction,
    bool signedInBefore) async {
  auth.AuthRepository authRepository = auth.AuthRepository.instance();
  bool signInAttempt = await loginFunction;
  if (signInAttempt) {
    signedInBefore
        ? await UserStorage.instance(authRepository).GET_postLogin()
        : UserStorage.instance(authRepository).SEND_generalInfo();
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
