// ================= login tab bar view widget=================
import 'package:balance_me/global/types.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/widgets/text_box_with_border.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/login_utils.dart';
import 'package:balance_me/widgets/forgot_password.dart';
import 'package:balance_me/widgets/third_party_authentication.dart';
import 'package:balance_me/widgets/login_image.dart';
import 'package:balance_me/widgets/action_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen(this._authRepository, this._userStorage, {Key? key})
      : super(key: key);
  final AuthRepository _authRepository;
  final UserStorage _userStorage;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = true;
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  bool _loading = false;

  void _isLoading(bool state) {
    setState(() {
      _loading = state;
    });
  }

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
      onPressed: hideText,
    );
  }

  Widget loginBody(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const LoginImage(),
          TextBox(controllerEmail, Languages.of(context)!.emailText),
          TextBox(
            controllerPassword,
            Languages.of(context)!.password,
            hideText: showPassword,
            suffix: hidingPasswordEye(),
          ),
          GoogleButton(widget._authRepository, widget._userStorage,
              isSignUp: false),
          FacebookButton(widget._authRepository, widget._userStorage,
              isSignUp: false),
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

  void signIn() {
    _isLoading(false);
    emailPasswordSignIn(controllerEmail.text, controllerPassword.text, context,
        widget._authRepository, widget._userStorage);
    _isLoading(true);
  }

  Widget signInButton(BuildContext context) {
    return ActionButton(_loading, Languages.of(context)!.signIn, signIn,
        style: filledButtonColor());
  }

  @override
  Widget build(BuildContext context) {
    return loginBody(context);
  }
}
