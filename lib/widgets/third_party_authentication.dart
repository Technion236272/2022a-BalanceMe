// ================= Google and Facebook buttons=================
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:auth_buttons/auth_buttons.dart';
import 'package:balance_me/global/login_utils.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton(this._authRepository, this._userStorage,
      {Key? key, this.isSignUp = true})
      : super(key: key);
  final bool isSignUp;
  final AuthRepository _authRepository;
  final UserStorage _userStorage;

  void onPressedGoogle(BuildContext context) {
    isSignUp
        ? signUpGoogle(context, _authRepository, _userStorage)
        : signInGoogle(context, _authRepository, _userStorage);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(gc.googleButtonPadding,
          gc.paddingFacebook, gc.paddingFacebook, gc.paddingFacebook),
      child: GoogleAuthButton(
        onPressed: () {
          onPressedGoogle(context);
        },
        darkMode: _userStorage.userData != null
            ? _userStorage.userData!.isDarkMode
            : gc.darkMode,
      ),
    );
  }
}

class FacebookButton extends StatelessWidget {
  const FacebookButton(this._authRepository, this._userStorage,
      {Key? key, this.isSignUp = true})
      : super(key: key);
  final bool isSignUp;
  final AuthRepository _authRepository;
  final UserStorage _userStorage;

  void onPressedFacebook(BuildContext context) {
    isSignUp
        ? signUpFacebook(context, _authRepository, _userStorage)
        : signInFacebook(context, _authRepository, _userStorage);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(gc.paddingFacebook),
      child: FacebookAuthButton(
        onPressed: () {
          onPressedFacebook(context);
        },
        darkMode: _userStorage.userData != null
            ? _userStorage.userData!.isDarkMode
            : gc.darkMode,
      ),
    );
  }
}
