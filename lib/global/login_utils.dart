import 'package:balance_me/firebase_wrapper/auth_repository.dart' as auth;
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/global/constants.dart' as gc;

void signInGoogle(BuildContext context) async {

  startLoginProcess(context, auth.AuthRepository.instance().signInGoogle(), true,gc.googleMethod);
}

void signInFacebook(BuildContext context) async {

  startLoginProcess(context, auth.AuthRepository.instance().signInWithFacebook(), true,gc.facebookMethod);
}

void signUpGoogle(BuildContext context) async {

  startLoginProcess(context, auth.AuthRepository.instance().signInGoogle(), false,gc.googleMethod);
}

void signUpFacebook(BuildContext context) async {
  startLoginProcess(context, auth.AuthRepository.instance().signInWithFacebook(), false,gc.facebookMethod);
}

void emailPasswordSignUp(String? email, String? password,
    String? confirmPassword, BuildContext context) async {
  if (email == null || password == null || confirmPassword == null) {
    displaySnackBar(context, Languages.of(context)!.nullDetails);
    return;
  }
startLoginProcess(context, auth.AuthRepository.instance().signUp(email, password), false,gc.emailWithPasswordMethod);

}

void emailPasswordSignIn(
    String? email, String? password, BuildContext context) async {
  if (email == null || password == null) {
    displaySnackBar(context, Languages.of(context)!.nullDetails);
    return;
  }
  startLoginProcess(context, auth.AuthRepository.instance().signIn(email, password), true,gc.emailWithPasswordMethod);
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


void startLoginProcess(BuildContext context,Future<bool> loginFunction,bool signedInBefore, String signUpMethod) async {
  auth.AuthRepository authRepository = auth.AuthRepository.instance();
  bool signInAttempt = await loginFunction;
  if (signInAttempt) {

   signedInBefore?await UserStorage.instance(authRepository).GET_postLogin():
   UserStorage.instance(authRepository).SEND_generalInfo();
   GoogleAnalytics.instance.logSignUp(signUpMethod);
    navigateBack(context);
  } else {
    displaySnackBar(context, Languages.of(context)!.loginError);
  }
}