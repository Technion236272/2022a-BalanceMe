import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/generic_button.dart';
import 'package:balance_me/widgets/text_box_with_border.dart';
import 'package:flutter/material.dart';
import 'appbar.dart';
import 'generic_tabs.dart';
import 'login_image.dart';

class CreateJoinGroup extends StatefulWidget {
  const CreateJoinGroup({Key? key}) : super(key: key);

  @override
  _CreateJoinGroupState createState() => _CreateJoinGroupState();
}

class _CreateJoinGroupState extends State<CreateJoinGroup> {
  int appBarChoice = 0;
  TextEditingController controllerGroupName = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();

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

  void onSwitchGroup(int tabIndex) {
    setState(() {
      appBarChoice = tabIndex;
    });
  }

  @override
  void dispose() {
    controllerGroupName.dispose();
    controllerDescription.dispose();
    super.dispose();
  }

  Widget createGroup() {
    return Column(
        children: [
        LoginImage(),
    Text(Languages.of(context)!.createGroupInstructions),
    TextBox(controllerGroupName, Languages.of(context)!.groupName),
    TextBox(controllerDescription, Languages.of(context)!.descriptionInstruction),
      GenericButton(buttonText: Languages.of(context)!.create,buttonColor: gc.alternativePrimary,
      onPressed: (){createGroupFirebase();},
      ),
    ],
    );
  }
void createGroupFirebase()
{

}
  Widget joinGroup() {
    return Column();
  }

  List<Widget> groupTabBarView() {
    return [
      createGroup(), joinGroup()
    ];
  }

  Widget createJoinGroup() {
    return Scaffold(
      appBar: appBarChoice == 0
          ? MinorAppBar(capitalize(Languages.of(context)!.create) + ' ' +
          Languages.of(context)!.group)
          : MinorAppBar(capitalize(Languages.of(context)!.join) + ' ' +
          Languages.of(context)!.group),
      body: TabGeneric(tabsList(), groupTabBarView(), onSwitch: onSwitchGroup,),
    );
  }


  @override
  Widget build(BuildContext context) {
    return createJoinGroup();
  }
}
