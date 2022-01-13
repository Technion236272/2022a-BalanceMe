// ================= Change password signed in page =================
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/global/login_utils.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/widgets/action_button.dart';
import 'package:balance_me/widgets/authentication/generic_password_eye.dart';
import 'package:balance_me/widgets/text_box_with_border.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/localization/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/widgets/appbar.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key, required this.authRepository})
      : super(key: key);
  final AuthRepository authRepository;

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _controllerNewPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword = TextEditingController();
  bool _loading=false;
  bool _showPassword = true;
  bool _showConfirmPassword = true;

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

  @override
  void dispose() {
    _controllerNewPassword.dispose();
    _controllerConfirmPassword.dispose();
    super.dispose();
  }

  void _updatePassword() {
    _isLoading(false);
    changePassword(_controllerNewPassword.text, _controllerConfirmPassword.text);
    _isLoading(true);
  }

  void changePassword(String newPassword, String confirmPassword) async {
    newPassword == confirmPassword
        ? await widget.authRepository.updatePassword(context, newPassword)
        : displaySnackBar(context, Languages.of(context)!.strMismatchingPasswords);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MinorAppBar(Languages.of(context)!.strNewPassword),
      body: SingleChildScrollView(
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
            TextBox(_controllerNewPassword, Languages.of(context)!.strNewPassword,hideText: _showPassword,suffix: PasswordEye(_showPassword,_hideText),),
            TextBox(_controllerConfirmPassword, Languages.of(context)!.strConfirmPassword,hideText: _showConfirmPassword, suffix: PasswordEye(_showConfirmPassword,_hideConfirmText),),
            ActionButton(_loading, Languages.of(context)!.strFinish, _updatePassword, fillStyle:true),
          ],
        ),
      ),
    );
  }
}
