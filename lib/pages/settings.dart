//this page will contain the settings UI

import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/languages_drop_down.dart' as drop;
import 'package:balance_me/global/project_config.dart' as pro;
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as co;

//TODO: test this after appBar is implemented
class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        Languages.of(context)!.settingsTitle,
      )),
      body: mainSettingsList(),
    );

    //return Container();
  }

  Widget mainSettingsList() {
    return ListView(
      children: [
        //profile
        Container(
          child: Row(
            children: [
              Text(Languages.of(context)!.profileSettings),
              IconButton(onPressed: getProfileScreen, icon: co.settingArrow),
            ],
          ),
        ),
        //group
        Container(
          child: Row(
            children: [
              Text(Languages.of(context)!.groupSettings),
              IconButton(onPressed: getGroupScreen, icon: co.settingArrow)
            ],
          ),
        ),
        //change password
        Container(
          child: Row(
            children: [
              Text(Languages.of(context)!.passwordSettings),
              IconButton(
                  onPressed: getChangePasswordScreen, icon: co.settingArrow)
            ],
          ),
        ),
        //Dark mode
        Container(
          child: Row(
            children: [
              Text(Languages.of(context)!.darkModeSettings),
              Switch(value: isDark(), onChanged: setDarkMode)
            ],
          ),
        ),
        //End of month
        Container(
          child: Row(
            children: [
              Text(Languages.of(context)!.endOfMonthSettings),
              //consider changing to constants
              Radio(
                  value: co.daysOfMonth[0],
                  groupValue: getDayOfMonth,
                  onChanged: setDayOfMonth),
              Radio(
                  value: co.daysOfMonth[1],
                  groupValue: getDayOfMonth,
                  onChanged: setDayOfMonth),
              Radio(
                  value: co.daysOfMonth[2],
                  groupValue: getDayOfMonth,
                  onChanged: setDayOfMonth)
            ],
          ),
        ),
        //language
        Container(
          child: Row(
            children: [
              Text(Languages.of(context)!.languageSettings),
              //TODO: find out how to pass build of one Stateful widget to another
              drop.LanguageDropDown as Widget
              //drop.LanguageDropDown,
            ],
          ),
        ),
        //version
        Container(
          child: Row(
            children: [
              Text(Languages.of(context)!.versionSettings),
              Text(pro.projectVersion)
            ],
          ),
        )
      ],
    );
  }

  //TODO: create a profile editing screen
  Widget getProfileScreen() {
    return Container();
  }

  //TODO: create a group editing screen
  Widget getGroupScreen() {
    return Container();
  }

  //TODO: create a password editing screen
  Widget getChangePasswordScreen() {
    return Container();
  }

  //TODO: read how to add dark mode and add a boolean to track it.
  void setDarkMode(bool isDark) {
    ;
  }

  //TODO: create a function that checks if the user has dark mode on
  bool isDark() {
    return co.darkMode;
  }

  //TODO: get day of the month from firebase
  int getDayOfMonth() {return 1;}
  //TODO: set day of the month according to integer from daysOfMonth list
  void setDayOfMonth(Object? value) {}
}
