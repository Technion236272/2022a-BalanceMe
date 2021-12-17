// ================= sign up page =================
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/widgets/text_box_with_border.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/global/login_utils.dart' as util;
import 'package:balance_me/widgets/third_party_authentication.dart';
import 'package:balance_me/widgets/login_image.dart';

class SignUp extends StatefulWidget {
  const SignUp(this._authRepository,this._userStorage,{Key? key}) : super(key: key);
  final AuthRepository _authRepository;
  final UserStorage _userStorage;

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
            GoogleButton(widget._authRepository,widget._userStorage),
            FacebookButton(widget._authRepository,widget._userStorage),
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
                context,widget._authRepository,widget._userStorage);
          },
          child: Text(
            Languages.of(context)!.signUpTitle,
            style: const TextStyle(fontSize: gc.signInOrUpFontSize),
          )),
    );
  }
}
