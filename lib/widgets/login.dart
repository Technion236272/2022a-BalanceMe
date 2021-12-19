// ================= Login Page =================
import 'package:flutter/material.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/widgets/text_box_with_border.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/login_utils.dart';
import 'package:balance_me/widgets/forgot_password.dart';
import 'package:balance_me/widgets/third_party_authentication.dart';
import 'package:balance_me/widgets/login_image.dart';
import 'package:balance_me/widgets/action_button.dart';
import 'package:balance_me/global/constants.dart' as gc;

class LoginScreen extends StatefulWidget {
  const LoginScreen(this._authRepository, this._userStorage, {Key? key}) : super(key: key);

  final AuthRepository _authRepository;
  final UserStorage _userStorage;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  bool _loading = false;
  bool showPassword = true;

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

  IconButton _hidingPasswordEye() {
    return IconButton(
      icon: Icon(showPassword ? gc.hidePassword : gc.showPassword),
      color: gc.hidePasswordColor,
      onPressed: _hideText,
    );
  }

  String? _essentialFieldValidatorFunction(String? value) {
    return essentialFieldValidator(value) ? null : Languages.of(context)!
        .essentialField;
  }

  String? _passwordValidatorFunction(String? value) {
    String? message = _essentialFieldValidatorFunction(value);
    if (message == null) {
      return lineLimitMinValidator(value, gc.defaultMinPasswordLimit)
          ? null
          : Languages.of(context)!.minPasswordLimit.replaceAll(
          "%", gc.defaultMinPasswordLimit.toString());
    }
    return message;
  }

  Widget _loginBody(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const LoginImage(),
          TextBox(
            controllerEmail,
            Languages.of(context)!.emailText,
            validatorFunction: _essentialFieldValidatorFunction,
          ),
          TextBox(
            controllerPassword,
            Languages.of(context)!.password,
            hideText: showPassword,
            suffix: _hidingPasswordEye(),
            validatorFunction: _passwordValidatorFunction,
          ),
          GoogleButton(
              widget._authRepository,
              widget._userStorage,
              isSignUp: false
          ),
          FacebookButton(
            widget._authRepository,
            widget._userStorage,
            isSignUp: false,
          ),
          _forgotPasswordLink(context),
          _signInButton(context),
        ],
      ),
    );
  }

  TextButton _forgotPasswordLink(BuildContext context) {
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

  void _hideText() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  Widget _signInButton(BuildContext context) {
    return ActionButton(_loading, Languages.of(context)!.signIn, _signIn,
        style: filledButtonColor());
  }

  void _signIn() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _isLoading(false);
      emailPasswordSignIn(
          controllerEmail.text, controllerPassword.text, context,
          widget._authRepository, widget._userStorage);
      _isLoading(true);
    }
  }


  @override
  Widget build(BuildContext context) {
    return _loginBody(context);
  }
}
