import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/text_box_with_border.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/global/login_utils.dart' as util;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController controllerEmail = TextEditingController();

  @override
  void dispose() {
    controllerEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return forgotPasswordPage(context);
  }

  Widget forgotPasswordPage(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MinorAppBar(Languages.of(context)!.recoverPassword),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              gc.sidePadding,
              MediaQuery.of(context).size.height / gc.padWithImage,
              gc.sidePadding,
              gc.sidePadding),
          child: Column(
            children: [
              Image.asset(gc.lock),
              Text(
                Languages.of(context)!.forgotPasswordLarge,
                style: const TextStyle(fontSize: gc.forgotPasswordSize),
              ),
              Text(
                Languages.of(context)!.confirmEmail,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: gc.forgotPasswordMsgSize),
              ),
              emailTextBox(context,controllerEmail),
              SizedBox(
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            gc.alternativePrimary)),
                    onPressed: () {
                      util.recoverPassword(controllerEmail.text, context);
                    },
                    child: Text(Languages.of(context)!.send)),
              )
            ],
          ),
        ),
      ),
    );
  }


}
