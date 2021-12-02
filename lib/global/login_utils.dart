import 'package:balance_me/firebase_wrapper/auth_repository.dart' as auth;
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

void signInGoogle(BuildContext context) async {
  auth.AuthRepository authRepository = auth.AuthRepository.instance();
  bool signInAttempt = await authRepository.signInGoogle();
  if (signInAttempt) {
    navigateBack(context);
  } else {
    displaySnackBar(context, Languages.of(context)!.loginError);
  }
}

void signInFacebook(BuildContext context) async {
  auth.AuthRepository authRepository = auth.AuthRepository.instance();
  bool signInAttempt = await authRepository.signInWithFacebook();
  if (signInAttempt) {
    navigateBack(context);
  } else {
    displaySnackBar(context, Languages.of(context)!.loginError);
  }
}

void signUpGoogle(BuildContext context) async {
  auth.AuthRepository authRepository = auth.AuthRepository.instance();
  bool signInAttempt = await authRepository.signInGoogle();
  if (signInAttempt) {
    navigateBack(context);
  } else {
    displaySnackBar(context, Languages.of(context)!.loginError);
  }
}

void signUpFacebook(BuildContext context) async {
  auth.AuthRepository authRepository = auth.AuthRepository.instance();
  bool signInAttempt = await authRepository.signInWithFacebook();
  if (signInAttempt) {
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
  // if (password != confirmPassword) {
  //   setState(() {
  //     arePasswordsIdentical = !arePasswordsIdentical;
  //   });
  //   return;
  // }
  auth.AuthRepository _auth = auth.AuthRepository.instance();
  bool attempt = await _auth.signUp(email, password);
  if (attempt) {
    navigateBack(context);
  } else {
    displaySnackBar(context, Languages.of(context)!.signUpError);
  }
}

void emailPasswordSignIn(
    String? email, String? password, BuildContext context) async {
  if (email == null || password == null) {
    displaySnackBar(context, Languages.of(context)!.loginError);
    return;
  }
  auth.AuthRepository _auth = auth.AuthRepository.instance();
  bool signInSuccesful = await _auth.signIn(email, password);
  if (signInSuccesful) {
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
