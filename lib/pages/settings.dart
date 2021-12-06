import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/languages_drop_down.dart';
import 'package:balance_me/global/project_config.dart' as config;
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;


class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

//TODO: put final appbar here
class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainSettingsList(),
    );

    //return Container();
  }

  Widget mainSettingsList() {
    return ListView(
      children: [    ListTile(

           leading: Text(Languages.of(context)!.profileSettings),
           trailing:
           IconButton(onPressed: getProfileScreen, icon: gc.settingArrow),
         ),
          Divider(color: gc.dividerColor,),
          ListTile(
            leading: Text(Languages.of(context)!.groupSettings),
              trailing:  IconButton(onPressed: getGroupScreen, icon: gc.settingArrow),
          ),
        Divider(color: gc.dividerColor,),
          ListTile(
            leading: Text(Languages.of(context)!.passwordSettings),
    trailing: IconButton(onPressed: getChangePasswordScreen, icon: gc.settingArrow),
          ),
        Divider(color: gc.dividerColor,),
        ListTile(
            leading:Text(Languages.of(context)!.darkModeSettings),
            trailing: Switch(value: isDark(), onChanged: setDarkMode),
        ),
        Divider(color: gc.dividerColor,),
        ListTile(
            leading: Text(Languages.of(context)!.endOfMonthSettings),
            // trailing: daysOfMonthRadio(),
        ),
        Divider(color: gc.dividerColor,),
        ListTile(
            leading: Text(Languages.of(context)!.languageSettings),
            trailing:  LanguageDropDown(),
        ),
        Divider(color: gc.dividerColor,),
        ListTile(
          leading:Text(Languages.of(context)!.versionSettings) ,
            trailing: const Text(config.projectVersion)
        ),
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
    return gc.darkMode;
  }

  //TODO: get day of the month from firebase
  int getDayOfMonth() {
    return 1;
  }

  //TODO: set day of the month according to integer from daysOfMonth list
  void setDayOfMonth(Object? value) {}

  //TODO: generate radios for days of month
  Widget daysOfMonthRadio() {
    return Row(
      // children: [Radio(value: value, groupValue: groupValue, onChanged: onChanged)],
    );
  }
}
