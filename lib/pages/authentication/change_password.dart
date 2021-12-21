// ================= Change password signed in page =================
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/global/login_utils.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/widgets/action_button.dart';
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

  void _isLoading(bool state) {
    setState(() {
      _loading = state;
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
        : displaySnackBar(context, Languages.of(context)!.invalidPasswords);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MinorAppBar(Languages.of(context)!.newPassword),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              gc.key,
              height: MediaQuery.of(context).size.height / gc.keyScale,
            ),
            Text(
              Languages.of(context)!.passwordUpdate,
              style: const TextStyle(fontSize: gc.newPasswordSize),
            ),
            TextBox(_controllerNewPassword, Languages.of(context)!.newPassword),
            TextBox(_controllerConfirmPassword,
                Languages.of(context)!.confirmPassword),
            ActionButton(
                _loading, Languages.of(context)!.finish, _updatePassword,
                fillStyle:true),
          ],
        ),
      ),
    );
  }
}
