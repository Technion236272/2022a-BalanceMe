import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:auth_buttons/auth_buttons.dart';
import 'package:balance_me/global/login_utils.dart' as util;
Padding googlebutton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(gc.googleButtonPadding,
        gc.paddingFacebook, gc.paddingFacebook, gc.paddingFacebook),
    child: GoogleAuthButton(
      onPressed: () {
        util.signUpGoogle(context);
      },
      darkMode: false,
      style:  AuthButtonStyle(

      ),
    ),
  );
}
Padding facebookButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(gc.paddingFacebook),
    child: FacebookAuthButton(
      onPressed: () {
        util.signUpFacebook(context);
      },
      darkMode: false,
      style: const AuthButtonStyle(

      ),
    ),
  );
}

