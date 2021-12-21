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
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
      Image.asset(
        gc.balanceImage,
        width: MediaQuery.of(context).size.width / gc.imageScale,
        height: MediaQuery.of(context).size.height / gc.imageScale,
      ),
      GenericInfo(
        title: Provider.of<AuthRepository>(context, listen: false).status == AuthStatus.Authenticated ? Languages.of(context)!.welcomeBack : Languages.of(context)!.welcomeAboard,
        topInfo: Languages.of(context)!.balanceInfo,
        bottomInfo: Languages.of(context)!.toGetStartedInfo,
      ),
    ]);
  }
}
