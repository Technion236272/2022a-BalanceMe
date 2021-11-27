import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
//place all tabs here
class TabLogin extends StatefulWidget {
  const TabLogin({Key? key}) : super(key: key);

  @override
  _TabLoginState createState() => _TabLoginState();
}

class _TabLoginState extends State<TabLogin> {
  @override
  Widget build(BuildContext context) {
    return createTabController(2, tabs(context));
  }
  //TODO: tabBar has no dispose method, find out how to dispose
  DefaultTabController createTabController(int numTabs,Widget tabs)
  {
    return DefaultTabController(length: numTabs, child: tabs);
  }

  Widget tabs(BuildContext context)
  {
    return Container(child: TabBar(tabs: [Tab(child:
    Text(Languages.of(context)!.loginTitle)),
      Tab(child:Text(Languages.of(context)!.signUpTitle) ,)],),);
  }
}
