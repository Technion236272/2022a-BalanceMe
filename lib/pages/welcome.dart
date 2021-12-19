// ================= Welcome Page =================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/generic_info.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/constants.dart' as gc;

class WelcomePage extends StatelessWidget {
  WelcomePage({Key? key}) : super(key: key) {
    GoogleAnalytics.instance.logPageOpened(AppPages.Welcome);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        left: MediaQuery.of(context).size.width / 3,
        top: gc.imageTop,
        child: Image.asset(
          gc.balanceImage,
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height / 3,
        ),
      ),
      GenericInfo(
        Provider.of<AuthRepository>(context, listen: false).status == AuthStatus.Authenticated ? Languages.of(context)!.welcomeBack : Languages.of(context)!.welcomeAboard,
        Languages.of(context)!.balanceInfo,
        Languages.of(context)!.toGetStartedInfo,
      ),
    ]);
  }
}
