import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/localization/resources/resources.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:balance_me/global/login_utils.dart' as util;
import 'package:balance_me/widgets/third_party_authentication.dart';
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
          Padding(
            padding: const EdgeInsets.all(gc.paddingBetweenText),
            child: TextFormField(
              controller: controllerConfirmPassword,
              obscureText: confirmPasswordVisible,
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
                      width: gc.borderWidth,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(gc.textFieldRadius),
                    borderSide:  BorderSide(
                      color: gc.primaryColor,
                      width: gc.borderWidth,
                    ),
                  )),
            ),
          ),

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
          );
  }

  Padding emailTextBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(gc.paddingBetweenText),
      child: TextFormField(
        controller: controllerEmail,
        decoration: InputDecoration(
          hintText: Languages.of(context)!.emailText,
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
          ),
        ),
      ),
    );
  }
}
