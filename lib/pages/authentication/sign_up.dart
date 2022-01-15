// ================= SignUp page =================
import 'package:balance_me/widgets/authentication/generic_password_eye.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/global/login_utils.dart';
import 'package:balance_me/widgets/text_box_with_border.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/authentication/third_party_authentication.dart';
import 'package:balance_me/widgets/authentication/login_image.dart';
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

  void _hideText() {
    setState(() {
      signUpPasswordVisible = !signUpPasswordVisible;
    });
  }

    void _hideConfirmText() {
      setState(() {
        confirmPasswordVisible = !confirmPasswordVisible;
      });
    }

      String? _essentialFieldValidatorFunction(String? value) {
        return essentialFieldValidator(value) ? null : Languages.of(context)!
            .strEssentialField;
      }

      String? _emailValidatorFunction(String? value) {
        String? message = _essentialFieldValidatorFunction(value);
        if (message == null) {
          return emailValidator(value) ? null : Languages.of(context)!
              .strBadEmail;
        }
        return message;
      }

      String? _passwordValidatorFunction(String? value) {
        String? message = _essentialFieldValidatorFunction(value);
        if (message == null) {
          return lineLimitMinValidator(value, gc.defaultMinPasswordLimit)
              ? null
              : Languages.of(context)!.strMinPasswordLimit.replaceAll(
              "%", gc.defaultMinPasswordLimit.toString());
        }
        return message;
      }

      String? _confirmPasswordValidatorFunction(String? value) {
        String? message = _passwordValidatorFunction(value);
        String? confirmMessage = _passwordValidatorFunction(
            controllerPassword.text);
        if (message == null && confirmMessage == null) {
          return matchingPasswordValidator(value, controllerPassword.text)
              ? null
              : Languages.of(context)!.strMismatchingPasswords;
        }
        return message;
      }

      void _signUp() {
        if (_formKey.currentState != null &&
            _formKey.currentState!.validate()) {
          _updatePerformingLogin(true);
          emailPasswordSignUp(controllerEmail.text, controllerPassword.text,
              controllerConfirmPassword.text, context, widget._authRepository,
              widget._userStorage, failureCallback: () {
                _updatePerformingLogin(false);
              });
        }
      }

      @override
      Widget build(BuildContext context) {
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * gc.pageHeightFactor,
              child: Column(
                children: [
                  const LoginImage(),
                  TextBox(
                    controllerEmail,
                    Languages.of(context)!.strEmailText,
                    validatorFunction: _emailValidatorFunction,
                  ),
                  TextBox(
                    controllerPassword,
                    Languages.of(context)!.strPassword,
                    hideText: signUpPasswordVisible,
                    suffix: PasswordEye(signUpPasswordVisible, _hideText),
                    validatorFunction: _passwordValidatorFunction,
                  ),
                  TextBox(
                    controllerConfirmPassword,
                    Languages.of(context)!.strConfirmPassword,
                    hideText: confirmPasswordVisible,
                    suffix: PasswordEye(
                        confirmPasswordVisible, _hideConfirmText),
                    validatorFunction: _confirmPasswordValidatorFunction,
                  ),
                  SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / gc.buttonsScale,
                      child: GoogleButton(
                          widget._authRepository, widget._userStorage)),
                  SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / gc.buttonsScale,
                      child: FacebookButton(
                          widget._authRepository, widget._userStorage)),
                  _performingLogin
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : ElevatedButton(
                    child: Text(Languages.of(context)!.strSignUp),
                    onPressed: _signUp,
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }

