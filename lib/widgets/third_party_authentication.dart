import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:auth_buttons/auth_buttons.dart';
import 'package:balance_me/global/login_utils.dart' as util;

class GoogleButton extends StatelessWidget {
   GoogleButton(this._authRepository,this._userStorage,{Key? key, this.isSignUp=true}) : super(key: key);
final bool isSignUp;
final AuthRepository _authRepository;
final UserStorage _userStorage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(gc.googleButtonPadding,
          gc.paddingFacebook, gc.paddingFacebook, gc.paddingFacebook),
      child: GoogleAuthButton(
        onPressed: () {

          if (isSignUp)
          {
            util.signUpGoogle(context,_authRepository,_userStorage);
          }
          else
            {
              util.signInGoogle(context,_authRepository,_userStorage);
            }
        },
        darkMode:_userStorage.userData!=null?
        _userStorage.userData!.isDarkMode:false,
      ),
    );
  }
}

class FacebookButton extends StatelessWidget {
   FacebookButton(this._authRepository,this._userStorage,{Key? key, this.isSignUp=true}) : super(key: key);
   final bool isSignUp;
   final AuthRepository _authRepository;
   final UserStorage _userStorage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(gc.paddingFacebook),
      child: FacebookAuthButton(
        onPressed: () {

          if (isSignUp) {
            util.signUpFacebook(context,_authRepository,_userStorage);
          }
          else
            {
              util.signInFacebook(context,_authRepository,_userStorage);
            }
        },
        darkMode: _userStorage.userData!=null?
        _userStorage.userData!.isDarkMode:false,
      ),
    );
  }
}
