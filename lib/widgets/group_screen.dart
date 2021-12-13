import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/widgets/generic_tabs.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/widgets/login_image.dart';
import 'package:balance_me/global/constants.dart' as gc;

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key, required this.authRepository, required this.userStorage}) : super(key: key);
  final AuthRepository authRepository;
  final UserStorage userStorage;
  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  int appBarChoice = 0;
  Widget groupScreenHasGroup() {
    return Column(
        children: [
          LoginImage(),
          Text(widget.userStorage.userData!.groupName),
          Text(Languages.of(context)!.members),
          //TODO: request the group members from server
          Text(Languages.of(context)!.description),
          //TODO: get group description
          SizedBox(
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        gc.leaveColor)),
                onPressed: () {
                  //TODO: set a leave group function
                },
                child: Text(Languages.of(context)!.leaveGroup)),
          )
        ],
    );
  }
  List<String> tabNames() {
    return [Languages.of(context)!.create, Languages.of(context)!.join];
  }
  List<Tab> tabsList() {
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
  bool hasGroup()
{
  return widget.authRepository.isAuthenticated && widget.userStorage.userData!=null
  && widget.userStorage.userData!.groupName!=widget.authRepository.user!.email
  ;

}

  List<Widget> groupTabBarView() {
    return [
    
    ];
  }

  String capitalize(String s)
  {
    return s[0].toUpperCase()+s.substring(1).toLowerCase();
  }
Widget createJoinGroup()
{

  return Scaffold(
    appBar: appBarChoice == 0
        ? MinorAppBar(capitalize(Languages.of(context)!.create)+Languages.of(context)!.group)
        : MinorAppBar(capitalize(Languages.of(context)!.join)+Languages.of(context)!.group),
    body:TabGeneric(tabsList(), groupTabBarView()),
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MinorAppBar(Languages.of(context)!.groupScreenTitle),
      body:hasGroup()? groupScreenHasGroup():createJoinGroup(),
    );
  }
}
