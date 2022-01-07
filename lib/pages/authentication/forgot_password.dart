import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/text_box_with_border.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/global/login_utils.dart' as util;
import 'package:balance_me/widgets/action_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController controllerEmail = TextEditingController();
  bool _loading = false;

  void _isLoading(bool state) {
    setState(() {
      _loading = state;
    });
  }

  @override
  void dispose() {
    controllerEmail.dispose();
    super.dispose();
  }

  void _recoverPassword() {
    _isLoading(false);
    util.recoverPassword(controllerEmail.text, context);
    _isLoading(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MinorAppBar(Languages.of(context)!.strRecoverPassword),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              gc.sidePadding,
              MediaQuery.of(context).size.height / gc.padWithImage,
              gc.sidePadding,
              gc.sidePadding),
          child: Column(
            children: [
              Image.asset(
                gc.lock,
                width: MediaQuery.of(context).size.width / gc.imageScale,
                height: MediaQuery.of(context).size.height / gc.imageScale,),
              Text(
                Languages.of(context)!.strForgotPasswordLink,
                style: const TextStyle(fontSize: gc.forgotPasswordSize),
              ),
              Text(
                Languages.of(context)!.strConfirmEmail,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: gc.forgotPasswordMsgSize),
              ),
              TextBox(controllerEmail, Languages.of(context)!.strEmailText),
              ActionButton(
                  _loading, Languages.of(context)!.strSend, _recoverPassword,
                  fillStyle: true,),
            ],
          ),
        ),
      ),
    );
  }
}
