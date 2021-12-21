// ================= SignUp page =================
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/global/login_utils.dart';
import 'package:balance_me/widgets/text_box_with_border.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/third_party_authentication.dart';
import 'package:balance_me/widgets/login_image.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/constants.dart' as gc;

class SignUp extends StatefulWidget {
  const SignUp(this._authRepository, this._userStorage, {Key? key}) : super(key: key);

  final AuthRepository _authRepository;
  final UserStorage _userStorage;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerConfirmPassword = TextEditingController();
  bool signUpPasswordVisible = true;
  bool confirmPasswordVisible = true;
  bool arePasswordsIdentical = true;
  bool _performingLogin = false;

  void _updatePerformingLogin(bool state) {
    setState(() {
      _performingLogin = state;
    });
  }

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    controllerConfirmPassword.dispose();
    super.dispose();
  }

  Widget _hidingPasswordEye() {
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

  Widget _hidingConfirmPasswordEye() {
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

  String? _essentialFieldValidatorFunction(String? value) {
    return essentialFieldValidator(value) ? null : Languages.of(context)!.essentialField;
  }

  String? _emailValidatorFunction(String? value) {
    String? message = _essentialFieldValidatorFunction(value);
    if (message == null) {
      return EmailValidator.validate(value!) ? null : Languages.of(context)!.badEmail;
    }
    return message;
  }

  String? _passwordValidatorFunction(String? value) {
    String? message = _essentialFieldValidatorFunction(value);
    if (message == null) {
      return lineLimitMinValidator(value, gc.defaultMinPasswordLimit) ? null : Languages.of(context)!.minPasswordLimit.replaceAll("%", gc.defaultMinPasswordLimit.toString());
    }
    return message;
  }

  void _signUp() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _updatePerformingLogin(true);
      emailPasswordSignUp(controllerEmail.text, controllerPassword.text, controllerConfirmPassword.text, context, widget._authRepository, widget._userStorage, failureCallback: () { _updatePerformingLogin(false); });
     }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const LoginImage(),
            TextBox(
              controllerEmail,
              Languages.of(context)!.emailText,
              validatorFunction: _emailValidatorFunction,
            ),
            TextBox(
              controllerPassword,
              Languages.of(context)!.password,
              hideText: signUpPasswordVisible,
              suffix: _hidingPasswordEye(),
              validatorFunction: _passwordValidatorFunction,
            ),
            TextBox(
              controllerConfirmPassword,
              Languages.of(context)!.confirmPassword,
              hideText: confirmPasswordVisible,
              suffix: _hidingConfirmPasswordEye(),
              validatorFunction: _passwordValidatorFunction,
            ),
            GoogleButton(widget._authRepository, widget._userStorage),
            FacebookButton(widget._authRepository, widget._userStorage),
            _performingLogin
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    child: Text(Languages.of(context)!.signIn),
                    onPressed: _signUp,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          gc.alternativePrimary),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
