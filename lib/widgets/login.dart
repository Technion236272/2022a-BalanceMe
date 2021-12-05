
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
          loginImage(context),
          emailTextBox(context,controllerEmail),
          Padding(
            padding: const EdgeInsets.all(gc.paddingBetweenText),
            child: TextFormField(
              obscureText: showPassword,
              controller: controllerPassword,
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
                      width: gc.borderWidth,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(gc.textFieldRadius),
                    borderSide: BorderSide(
                      color: gc.primaryColor,
                      width: gc.borderWidth,
                    ),
                  )),
            ),
          ),

googlebutton(context),
facebookButton(context),

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


  @override
  Widget build(BuildContext context) {
    return loginBody(context);
  }
}

