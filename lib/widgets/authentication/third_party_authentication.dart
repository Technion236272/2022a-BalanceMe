// ================= Google and Facebook buttons=================
import 'package:flutter/material.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:balance_me/global/login_utils.dart';
import 'package:balance_me/global/constants.dart' as gc;

class GoogleButton extends StatelessWidget {
  const GoogleButton(this._authRepository, this._userStorage, {Key? key, this.isSignUp = true}) : super(key: key);

  final bool isSignUp;
  final AuthRepository _authRepository;
  final UserStorage _userStorage;

  void _onPressedGoogle(BuildContext context) {
    isSignUp ? signUpGoogle(context, _authRepository, _userStorage) : signInGoogle(context, _authRepository, _userStorage);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(gc.paddingFacebook),
      child: GoogleAuthButton(
        onPressed: () {_onPressedGoogle(context);},
        darkMode: globalIsDarkMode,
        text: (isSignUp ? Languages.of(context)!.strSignUpWith : Languages.of(context)!.strLoginWith).replaceAll("%", Languages.of(context)!.strGoogle),
      ),
    );
  }
}

class FacebookButton extends StatelessWidget {
  const FacebookButton(this._authRepository, this._userStorage, {Key? key, this.isSignUp = true}) : super(key: key);

  final bool isSignUp;
  final AuthRepository _authRepository;
  final UserStorage _userStorage;

  void _onPressedFacebook(BuildContext context) {
    isSignUp ? signUpFacebook(context, _authRepository, _userStorage) : signInFacebook(context, _authRepository, _userStorage);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(gc.paddingFacebook),
      child: FacebookAuthButton(
        style: const AuthButtonStyle(padding: gc.googleFacebookAlignment),
        onPressed: () {_onPressedFacebook(context);},
        darkMode: globalIsDarkMode,
        text: (isSignUp ? Languages.of(context)!.strSignUpWith : Languages.of(context)!.strLoginWith).replaceAll("%", Languages.of(context)!.strFacebook),
      ),
    );
  }
}
