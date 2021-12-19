// ================= SignUp page =================
import 'package:flutter/material.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/global/login_utils.dart';
import 'package:balance_me/widgets/text_box_with_border.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/third_party_authentication.dart';
import 'package:balance_me/widgets/login_image.dart';
import 'package:balance_me/widgets/action_button.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/login_utils.dart' as util;
import 'package:balance_me/global/constants.dart' as gc;


class SignUp extends StatefulWidget {
  const SignUp(this._authRepository,this._userStorage,{Key? key}) : super(key: key);


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
              suffix: _hidingPasswordEye(),
            ),
            TextBox(
              controllerConfirmPassword,
              Languages.of(context)!.confirmPassword,
              hideText: confirmPasswordVisible,
              suffix: _hidingConfirmPasswordEye(),
            ),
            GoogleButton(widget._authRepository, widget._userStorage),
            FacebookButton(widget._authRepository, widget._userStorage),
            _signUpEmailPasswordButton(context),
          ],
        ),
      ),
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

    void _signUp() {

      if (_formKey.currentState != null && _formKey.currentState!.validate()) {
        _isLoading(false);
        util.emailPasswordSignUp(controllerEmail.text, controllerPassword.text,
            controllerConfirmPassword.text, context, widget._authRepository,
            widget._userStorage);
        _isLoading(true);
      }

    }

    IconButton _hidingPasswordEye() {
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

    IconButton _hidingConfirmPasswordEye() {
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


    ActionButton _signUpEmailPasswordButton(BuildContext context) {
      return ActionButton(
          _loading, Languages.of(context)!.signUpTitle, _signUp,
          style: filledButtonColor());
    }

      Widget _signUpBody(BuildContext context) {
        return SingleChildScrollView(
          child: Form(
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
                _signUpEmailPasswordButton(context),
              ],
            ),
          ),
        );
      }

      @override
      Widget build(BuildContext context) {
        return _signUpBody(context);
      }
    }

