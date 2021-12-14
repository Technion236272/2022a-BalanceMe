import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/widgets/generic_tabs.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/widgets/login.dart';
import 'package:balance_me/widgets/sign_up.dart';

class LoginManager extends StatefulWidget {
  const LoginManager(this._authRepository,this._userStorage,{Key? key}) : super(key: key);
  final AuthRepository _authRepository;
  final UserStorage _userStorage;
  @override
  _LoginManagerState createState() => _LoginManagerState();
}

class _LoginManagerState extends State<LoginManager> {
  int appBarChoice = 0;

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
            child: TabGeneric(loginTabs(), loginTabBarView(),
                onSwitch: changeAppbar)),
      ),
    );
  }

  void changeAppbar(int tabIndex) {
    setState(() {
      appBarChoice = tabIndex;
    });
  }

  List<String> tabNames() {
    return [Languages.of(context)!.login, Languages.of(context)!.signUpTitle];
  }

  List<Tab> loginTabs() {
    List<Tab> tabs = [];
    tabNames().forEach((element) {
      tabs.add(Tab(
        child: Text(
          element,
          style: const TextStyle(color: gc.tabTextColor),
        ),
      ));
    });
    return tabs;
  }

  List<Widget> loginTabBarView() {
    return [
       LoginScreen(widget._authRepository,widget._userStorage),
       SignUp(widget._authRepository,widget._userStorage),
    ];
  }
}
