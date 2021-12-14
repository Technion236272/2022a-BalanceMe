import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:auth_buttons/auth_buttons.dart';
import 'package:balance_me/global/login_utils.dart' as util;

class GoogleButton extends StatelessWidget {
   GoogleButton({Key? key, this.isSignUp=true}) : super(key: key);
final bool isSignUp;
AuthRepository authRepository=AuthRepository.instance();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(gc.googleButtonPadding,
          gc.paddingFacebook, gc.paddingFacebook, gc.paddingFacebook),
      child: GoogleAuthButton(
        onPressed: () {

          if (isSignUp)
          {
            util.signUpGoogle(context);
          }
          else
            {
              util.signInGoogle(context);
            }
        },
        darkMode:UserStorage.instance(authRepository).userData!=null?
          UserStorage.instance(authRepository).userData!.isDarkMode:false,
      ),
    );
  }
}

class FacebookButton extends StatelessWidget {
   FacebookButton({Key? key, this.isSignUp=true}) : super(key: key);
   final bool isSignUp;
  AuthRepository authRepository=AuthRepository.instance();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(gc.paddingFacebook),
      child: FacebookAuthButton(
        onPressed: () {

          if (isSignUp) {
            util.signUpFacebook(context);
          }
          else
            {
              util.signInFacebook(context);
            }
        },
        darkMode: UserStorage.instance(authRepository).userData!=null?
        UserStorage.instance(authRepository).userData!.isDarkMode:false,
      ),
    );
  }
}
