import 'package:balance_me/firebase_wrapper/auth_repository.dart' as auth;
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
void signInGoogle(BuildContext context) async {
  auth.AuthRepository authRepository = auth.AuthRepository.instance();
  bool signInAttempt = await authRepository.signInGoogle();
  if (signInAttempt) {
   await UserStorage.instance(authRepository).GET_postLogin();
    navigateBack(context);
  } else {
    displaySnackBar(context, Languages.of(context)!.loginError);
  }
}

void signInFacebook(BuildContext context) async {
  auth.AuthRepository authRepository = auth.AuthRepository.instance();
  bool signInAttempt = await authRepository.signInWithFacebook();
  if (signInAttempt) {
    await UserStorage.instance(authRepository).GET_postLogin();
    navigateBack(context);
  } else {
    displaySnackBar(context, Languages.of(context)!.loginError);
  }
}

void signUpGoogle(BuildContext context) async {
  auth.AuthRepository authRepository = auth.AuthRepository.instance();
  bool signInAttempt = await authRepository.signInGoogle();
  if (signInAttempt) {
     UserStorage.instance(authRepository).SEND_generalInfo();
    navigateBack(context);
  } else {
    displaySnackBar(context, Languages.of(context)!.loginError);
  }
}

void signUpFacebook(BuildContext context) async {
  auth.AuthRepository authRepository = auth.AuthRepository.instance();
  bool signInAttempt = await authRepository.signInWithFacebook();
  if (signInAttempt) {
    UserStorage.instance(authRepository).SEND_generalInfo();
    navigateBack(context);
  } else {
    displaySnackBar(context, Languages.of(context)!.loginError);
  }
}

void emailPasswordSignUp(String? email, String? password,
    String? confirmPassword, BuildContext context) async {
  if (email == null || password == null || confirmPassword == null) {
    displaySnackBar(context, Languages.of(context)!.nullDetails);
    return;
  }

  auth.AuthRepository authRepository = auth.AuthRepository.instance();
  bool attempt = await authRepository.signUp(email, password);
  if (attempt) {
    UserStorage.instance(authRepository).SEND_generalInfo();
    navigateBack(context);
  } else {
    displaySnackBar(context, Languages.of(context)!.signUpError);
  }
}

void emailPasswordSignIn(
    String? email, String? password, BuildContext context) async {
  if (email == null || password == null) {
    displaySnackBar(context, Languages.of(context)!.nullDetails);
    return;
  }
  auth.AuthRepository authRepository = auth.AuthRepository.instance();
  bool signInSuccessful = await authRepository.signIn(email, password);
  if (signInSuccessful) {
    await UserStorage.instance(authRepository).GET_postLogin();
    navigateBack(context);
  } else {
    displaySnackBar(context, Languages.of(context)!.loginError);
  }
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
