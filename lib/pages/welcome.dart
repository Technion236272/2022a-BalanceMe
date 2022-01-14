// ================= Welcome Page =================
import 'package:balance_me/widgets/balance/add_category_button.dart';
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
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              gc.balanceImage,
              width: MediaQuery.of(context).size.width / gc.imageScale,
              height: MediaQuery.of(context).size.height / gc.imageScale,
            ),
            AddCategoryButton(),
            GenericInfo(
              title: Provider.of<AuthRepository>(context, listen: false).status == AuthStatus.Authenticated ? Languages.of(context)!.strWelcomeBack : Languages.of(context)!.strWelcomeAboard,
              topInfo: Languages.of(context)!.strBalanceInfo,
              bottomInfo: Languages.of(context)!.strToGetStartedInfo,
            ),
          ]),
    );
  }
}
