import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/widgets/generic_tabs.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/widgets/login.dart';
import 'package:balance_me/widgets/sign_up.dart';

class LoginManager extends StatefulWidget {
  const LoginManager({Key? key}) : super(key: key);

  @override
  _LoginManagerState createState() => _LoginManagerState();
}

class _LoginManagerState extends State<LoginManager> {
  int appBarChoice = 0;

  void changeAppbar(int tabIndex) {
    setState(() {
      appBarChoice = tabIndex;
    });
  }

  List<String> getTabNames() {
    return [Languages.of(context)!.login, Languages.of(context)!.signUpTitle];
  }

  List<Widget> loginTabBarView() {
    return [
      const LoginScreen(),
      const SignUp(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: gc.loginTabs,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: appBarChoice == 0
            ? MinorAppBar(Languages.of(context)!.login)
            : MinorAppBar(Languages.of(context)!.signUpTitle),
        body: SingleChildScrollView(
            child: TabGeneric(getGenericTabs(getTabNames()), loginTabBarView(),
                onSwitch: changeAppbar)),
      ),
    );
  }
}
