// ================= Change password signed in page =================
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/widgets/action_button.dart';
import 'package:balance_me/widgets/authentication/generic_password_eye.dart';
import 'package:balance_me/widgets/text_box_with_border.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/localization/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/widgets/appbar.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key, required this.authRepository}) : super(key: key);
  final AuthRepository authRepository;

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerNewPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword = TextEditingController();
  bool _loading = false;
  bool _showPassword = true;
  bool _showConfirmPassword = true;

  @override
  void dispose() {
    _controllerNewPassword.dispose();
    _controllerConfirmPassword.dispose();
    super.dispose();
  }

  void _isLoading(bool state) {
    setState(() {
      _loading = state;
    });
  }

  void _hideText() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _hideConfirmText() {
    setState(() {
      _showConfirmPassword = !_showConfirmPassword;
    });
  }

  String? _essentialFieldValidatorFunction(String? value) {
    return essentialFieldValidator(value) ? null : Languages.of(context)!.strEssentialField;
  }

  String? _passwordValidatorFunction(String? value) {
    String? message = _essentialFieldValidatorFunction(value);
    if (message == null) {
      return lineLimitMinValidator(value, gc.defaultMinPasswordLimit) ? null
          : Languages.of(context)!.strMinPasswordLimit.replaceAll("%", gc.defaultMinPasswordLimit.toString());
    }
    return message;
  }

  String? _confirmPasswordValidatorFunction(String? value) {
    String? message = _passwordValidatorFunction(value);
    String? confirmMessage = _passwordValidatorFunction(_controllerConfirmPassword.text);
    if (message == null && confirmMessage == null) {
      return matchingPasswordValidator(value, _controllerConfirmPassword.text) ? null
          : Languages.of(context)!.strMismatchingPasswords;
    }
    return message;
  }

  void _updatePassword() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _isLoading(true);
      changePassword(_controllerNewPassword.text, _controllerConfirmPassword.text);
    }
  }

  void changePassword(String newPassword, String confirmPassword) async {
    if (newPassword == confirmPassword) {
      await widget.authRepository.updatePassword(context, newPassword, () {_isLoading(false);});
      displaySnackBar(context, Languages.of(context)!.strChangePasswordSuccess);
      navigateBack(context);
    } else {
      displaySnackBar(context, Languages.of(context)!.strMismatchingPasswords);
      _isLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MinorAppBar(Languages.of(context)!.strNewPassword),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                gc.key,
                width: MediaQuery.of(context).size.width / gc.imageScale,
                height: MediaQuery.of(context).size.height / gc.imageScale,
              ),
              Text(
                Languages.of(context)!.strPasswordUpdate,
                style: const TextStyle(fontSize: gc.newPasswordSize),
              ),
              TextBox(
                _controllerNewPassword,
                Languages.of(context)!.strNewPassword,
                hideText: _showPassword,
                suffix: PasswordEye(_showPassword, _hideText),
                validatorFunction: _passwordValidatorFunction,
              ),
              TextBox(
                _controllerConfirmPassword,
                Languages.of(context)!.strConfirmPassword,
                hideText: _showConfirmPassword,
                suffix: PasswordEye(_showConfirmPassword, _hideConfirmText),
                validatorFunction: _confirmPasswordValidatorFunction,
              ),
              ActionButton(_loading, Languages.of(context)!.strFinish, _updatePassword, fillStyle:true),
            ],
          ),
        ),
      ),
    );
  }
}
