import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/widgets/text_box_with_border.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/localization/resources/resources.dart';
import 'package:flutter/material.dart';
import 'appbar.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key, required this.authRepository}) : super(key: key);
final AuthRepository authRepository;
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController controllerNewPassword = TextEditingController();
  TextEditingController controllerConfirmPassword = TextEditingController();
  @override
  void dispose() {
    controllerNewPassword.dispose();
    controllerConfirmPassword.dispose();
    super.dispose();
  }
  Widget getChangePasswordScreen() {
    return Scaffold(
        resizeToAvoidBottomInset: true,
      appBar: MinorAppBar(Languages.of(context)!.newPassword),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(gc.key,height: MediaQuery.of(context).size.height/gc.keyScale,),
            Text(Languages.of(context)!.passwordUpdate,style: const TextStyle(fontSize: gc.newPasswordSize),),
            TextBox(controllerNewPassword, Languages.of(context)!.newPassword),
            TextBox(controllerConfirmPassword,
                Languages.of(context)!.confirmPassword),
            SizedBox(
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          gc.alternativePrimary)),
                  onPressed: () {
                  changePassword(controllerNewPassword.text,controllerConfirmPassword.text);
                  },
                  child: Text(Languages.of(context)!.finish)),
            )
          ],
        ),
      ),
    );
  }

  void changePassword(String newPassword,String confirmPassword) async
{

    newPassword==confirmPassword ? await widget.authRepository.updatePassword(context, newPassword):
    displaySnackBar(context, Languages.of(context)!.invalidPasswords)
    ;


}
  @override
  Widget build(BuildContext context) {
    return getChangePasswordScreen();
  }
}
