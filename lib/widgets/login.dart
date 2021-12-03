
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/global/utils.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:balance_me/widgets/generic_tabs.dart';
import 'package:balance_me/widgets/sign_up.dart';
import 'package:balance_me/global/login_utils.dart' as util;
import 'package:balance_me/widgets/forgot_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

//wallet:<a href="https://www.vecteezy.com/free-vector/wallet-icon">Wallet Icon Vectors by Vecteezy</a>
//lock:Stockio.com
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

  Widget loginBody(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Stack(children: [
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
          ]),
          emailTextBox(context),
          Padding(
            padding: const EdgeInsets.all(gc.paddingBetweenText),
            child: TextFormField(
              obscureText: showPassword,
              controller: controllerPassword,
              // onChanged: (String? value) {
              //   password = value;
              // },
              decoration: InputDecoration(
                  hintText: Languages.of(context)!.password,
                  suffixIcon: IconButton(
                    icon:
                    Icon(showPassword ? gc.hidePassword : gc.showPassword),
                    color: gc.hidePasswordColor,
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
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
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(gc.googleButtonPadding,
                    gc.paddingFacebook, gc.paddingFacebook, gc.paddingFacebook),
                child: GoogleAuthButton(
                  onPressed: () {
                    util.signInGoogle(context);
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
                    util.signInFacebook(context);
                  },
                  darkMode: false,
                  style: const AuthButtonStyle(
                    buttonType: AuthButtonType.icon,
                  ),
                ),
              ),
            ],
          ),
          TextButton(
              onPressed: () {
                navigateToPage(context, ForgotPassword());
              },
              child: Text(
                Languages.of(context)!.forgotPassword,
                style: TextStyle(color: gc.linkColors),
              )),
          signInButton(context),
        ],
      ),
    );
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
          child: Text(Languages.of(context)!.signIn)),
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

  @override
  Widget build(BuildContext context) {
    return loginBody(context);
  }
}

