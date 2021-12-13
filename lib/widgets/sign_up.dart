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
//TODO: check if it scrolls
  Widget signUpBody(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            const LoginImage(),
            TextBox(controllerEmail, Languages.of(context)!.emailText),
            TextBox(
              controllerPassword,
              Languages.of(context)!.password,
              hideText: signUpPasswordVisible,
              suffix: hidingPasswordEye(),
            ),
            TextBox(
              controllerConfirmPassword,
              Languages.of(context)!.confirmPassword,
              hideText: confirmPasswordVisible,
              suffix: hidingConfirmPasswordEye(),
            ),
            GoogleButton(),
            FacebookButton(),
            signUpEmailPasswordButton(context),
          ],
        ),
      ),
    );
  }

  IconButton hidingPasswordEye() {
    return IconButton(
      icon: Icon(signUpPasswordVisible ? gc.hidePassword : gc.showPassword),
      color: gc.hidePasswordColor,
      onPressed: () {
        setState(() {
          signUpPasswordVisible = !signUpPasswordVisible;
        });
      },
    );
  }

  IconButton hidingConfirmPasswordEye() {
    return IconButton(
      icon: Icon(confirmPasswordVisible ? gc.hidePassword : gc.showPassword),
      color: gc.hidePasswordColor,
      onPressed: () {
        setState(() {
          confirmPasswordVisible = !confirmPasswordVisible;
        });
      },
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
}
