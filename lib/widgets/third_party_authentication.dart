import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:auth_buttons/auth_buttons.dart';
import 'package:balance_me/global/login_utils.dart' as util;

class GoogleButton extends StatelessWidget {
  GoogleButton({Key? key}) : super(key: key);

  AuthRepository authRepository = AuthRepository.instance();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.3,
      child: Padding(
        padding: const EdgeInsets.all(gc.paddingFacebook),
        child: GoogleAuthButton(
          style: const AuthButtonStyle(
            textStyle:
                TextStyle(fontSize: gc.signInOrUpFontSize, color: Colors.black),
            iconSize: gc.signInIconSize,
          ),
          onPressed: () {
            util.signUpGoogle(context);
          },
          darkMode: UserStorage.instance(authRepository).userData != null
              ? UserStorage.instance(authRepository).userData!.isDarkMode
              : false,
        ),
      ),
    );
  }
}

class FacebookButton extends StatelessWidget {
  FacebookButton({Key? key}) : super(key: key);
  AuthRepository authRepository = AuthRepository.instance();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.3,
      child: Padding(
        padding: const EdgeInsets.all(gc.paddingFacebook),
        child: FacebookAuthButton(
          style: const AuthButtonStyle(
            padding: EdgeInsets.only(left: gc.buttonTextPadding),
            textStyle: TextStyle(fontSize: gc.signInOrUpFontSize),
            iconSize: gc.signInIconSize,
          ),
          onPressed: () {
            util.signUpFacebook(context);
          },
          darkMode: UserStorage.instance(authRepository).userData != null
              ? UserStorage.instance(authRepository).userData!.isDarkMode
              : false,
        ),
      ),
    );
  }
}
