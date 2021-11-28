import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/global/constants.dart' as gc;
//place all tabs here



//important- if the TabBarviewer doesn't show- wrap it with expanded
DefaultTabController createTabController(int numTabs,Widget tabs)
{
  return DefaultTabController(length: numTabs, child: tabs);
}
// class TabLogin extends StatefulWidget {
//   const TabLogin({Key? key}) : super(key: key);
//
//   @override
//   _TabLoginState createState() => _TabLoginState();
// }
//
// class _TabLoginState extends State<TabLogin> {
//   @override
//   Widget build(BuildContext context)
//   {
//    return Container();
//   }
//
//
//   @override
//   void initState ()
//   {
//     super.initState();
//   }
//}
