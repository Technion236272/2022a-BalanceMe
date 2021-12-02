import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/localization/resources/resources.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart' as auth;
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/pages/home.dart';
import 'package:balance_me/global/login_utils.dart' as util;

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
          Stack(
            children: [
              Image.asset(
                gc.wallet,
                height: MediaQuery.of(context).size.height / gc.walletScale,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(gc.padStackLeft, gc.padStackTop,
                    gc.padStackRight, gc.padStackBottom),
                child: Text(
                  Languages.of(context)!.appName,
                  style: TextStyle(color: gc.secondaryColor, fontSize: 16),
                ),
              )
            ],
          ),
          emailTextBox(context),
          Padding(
            padding: const EdgeInsets.all(gc.paddingBetweenText),
            child: TextFormField(
              controller: controllerPassword,
              obscureText: signUpPasswordVisible,
              // onChanged: (String? value) {
              //   password = value;
              // },
              decoration: InputDecoration(
                  hintText: Languages.of(context)!.password,
                  suffixIcon: IconButton(
                    icon: Icon(signUpPasswordVisible
                        ? gc.hidePassword
                        : gc.showPassword),
                    color: gc.hidePasswordColor,
                    onPressed: () {
                      setState(() {
                        signUpPasswordVisible = !signUpPasswordVisible;
                      });
                    },
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(gc.textFieldRadius),
                    borderSide: BorderSide(
                      color: gc.primaryColor,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(gc.textFieldRadius),
                    borderSide: BorderSide(
                      color: gc.primaryColor,
                      width: 2.0,
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(gc.paddingBetweenText),
            child: TextFormField(
              controller: controllerConfirmPassword,
              obscureText: confirmPasswordVisible,
              // onChanged: (String? value) {
              //   confirmPassword = value;
              // },
              decoration: InputDecoration(
                  errorText: arePasswordsIdentical
                      ? null
                      : Languages.of(context)!.invalidPasswords,
                  hintText: Languages.of(context)!.confirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(confirmPasswordVisible
                        ? gc.hidePassword
                        : gc.showPassword),
                    color: gc.hidePasswordColor,
                    onPressed: () {
                      setState(() {
                        confirmPasswordVisible = !confirmPasswordVisible;
                      });
                    },
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(gc.textFieldRadius),
                    borderSide: BorderSide(
                      color: gc.primaryColor,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(gc.textFieldRadius),
                    borderSide: const BorderSide(
                      color: gc.primaryColor,
                      width: 2.0,
                    ),
                  )),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(gc.googleButtonPadding,
                    gc.paddingFacebook, gc.paddingFacebook, gc.paddingFacebook),
                child: GoogleAuthButton(
                  onPressed: () {
                    util.signUpGoogle(context);
                  },
                  darkMode: false,
                  style: const AuthButtonStyle(
                    buttonType: AuthButtonType.icon,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(gc.paddingFacebook),
                child: FacebookAuthButton(
                  onPressed: () {
                    util.signUpFacebook(context);
                  },
                  darkMode: false,
                  style: const AuthButtonStyle(
                    buttonType: AuthButtonType.icon,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SizedBox(
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          gc.alternativePrimary)),
                  onPressed: () {
                    util.emailPasswordSignUp(
                        controllerEmail.text,
                        controllerPassword.text,
                        controllerConfirmPassword.text,
                        context);
                  },
                  child: Text(Languages.of(context)!.signUpTitle)),
            ),
          ),
        ],
      ),
    );
  }

  Padding emailTextBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(gc.paddingBetweenText),
      child: TextFormField(
        controller: controllerEmail,
        // onChanged: (String? value) {
        //   email = value;
        // },
        decoration: InputDecoration(
          hintText: Languages.of(context)!.emailText,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(gc.textFieldRadius),
            borderSide: BorderSide(
              color: gc.primaryColor,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(gc.textFieldRadius),
            borderSide: BorderSide(
              color: gc.primaryColor,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
