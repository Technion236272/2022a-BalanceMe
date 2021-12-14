import 'package:balance_me/global/types.dart';
import 'package:balance_me/main.dart';
import 'package:balance_me/widgets/text_box_with_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/login_utils.dart' as util;
import 'package:balance_me/widgets/forgot_password.dart';
import 'package:balance_me/widgets/third_party_authentication.dart';
import 'package:balance_me/widgets/login_image.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = true;
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  void changePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  IconButton hidingPasswordEye() {
    return IconButton(
      icon: Icon(showPassword ? gc.hidePassword : gc.showPassword),
      color: gc.hidePasswordColor,
      onPressed: () {
        hideText();
      },
    );
  }

  Widget loginBody(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const LoginImage(),
          BorderTextBox(controllerEmail, Languages.of(context)!.emailText),
          BorderTextBox(
            controllerPassword,
            Languages.of(context)!.password,
            hideText: showPassword,
            suffix: hidingPasswordEye(),
          ),
          GoogleButton(),
          FacebookButton(),
          forgotPasswordLink(context),
          signInButton(context),
        ],
      ),
    );
  }

  TextButton forgotPasswordLink(BuildContext context) {
    return TextButton(
        onPressed: () {
          navigateToPage(
              context, const ForgotPassword(), AppPages.ForgotPassword);
        },
        child: Text(
          Languages.of(context)!.forgotPassword,
          style: const TextStyle(color: gc.linkColors),
        ));
  }

  void hideText() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  SizedBox signInButton(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(gc.alternativePrimary)),
          onPressed: () {
            util.emailPasswordSignIn(
                controllerEmail.text, controllerPassword.text, context);
          },
          child: Text(
            Languages.of(context)!.signIn,
            style: const TextStyle(fontSize: gc.signInOrUpFontSize),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loginBody(context);
  }
}
