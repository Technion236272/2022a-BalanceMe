import 'package:balance_me/widgets/text_box_with_border.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/global/login_utils.dart' as util;
import 'package:balance_me/widgets/third_party_authentication.dart';
import 'package:balance_me/widgets/login_image.dart';
import 'package:balance_me/widgets/text_box_with_border.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerConfirmPassword = TextEditingController();
  bool signUpPasswordVisible = true;
  bool confirmPasswordVisible = true;
  bool arePasswordsIdentical = true;

  @override
  Widget build(BuildContext context) {
    return signUpBody(context);
  }

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    controllerConfirmPassword.dispose();
    super.dispose();
  }

  Widget signUpBody(BuildContext context) {
    return Form(
      child: Column(
        children: [
          loginImage(context),
          emailTextBox(context, controllerEmail),
          passwordTextBox(
              context, signUpPasswordVisible, controllerPassword, hideText),
          passwordTextBox(
              context,
              confirmPasswordVisible,
              controllerConfirmPassword,
              hideConfirmText,
              Languages.of(context)!.confirmPassword),
          googlebutton(context),
          facebookButton(context),
          signUpEmailPasswordButton(context),
        ],
      ),
    );
  }

  SizedBox signUpEmailPasswordButton(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(gc.alternativePrimary)),
          onPressed: () {
            util.emailPasswordSignUp(
                controllerEmail.text,
                controllerPassword.text,
                controllerConfirmPassword.text,
                context);
          },
          child: Text(Languages.of(context)!.signUpTitle)),
    );
  }

  void hideText() {
    setState(() {
      signUpPasswordVisible = !signUpPasswordVisible;
    });
  }

  void hideConfirmText() {
    setState(() {
      confirmPasswordVisible = !confirmPasswordVisible;
    });
  }
}
