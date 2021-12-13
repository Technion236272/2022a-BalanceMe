import 'package:balance_me/common_models/user_model.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/change_password.dart';
import 'package:balance_me/widgets/languages_drop_down.dart';
import 'package:balance_me/global/project_config.dart' as config;
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/widgets/generic_listview.dart';
import 'package:balance_me/widgets/generic_radio_button.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/widgets/profile_settings.dart';

class Settings extends StatefulWidget {
  const Settings(this.authRepository,this.userStorage,{Key? key}) : super(key: key);
final AuthRepository authRepository;
final UserStorage userStorage;
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainSettingsList(),
    );

    //return Container();
  }

  Widget mainSettingsList() {
    List<Widget?> leadingSettings = [
      Text(Languages.of(context)!.profileSettings),
      Text(Languages.of(context)!.groupSettings),
      Text(Languages.of(context)!.passwordSettings),
      Text(Languages.of(context)!.darkModeSettings),
      Text(Languages.of(context)!.endOfMonthSettings),
      Text(Languages.of(context)!.languageSettings),
      Text(Languages.of(context)!.versionSettings)
    ];
    List<Widget?> trailingSettings = [
      IconButton(
          onPressed: () {
            navigateToPage(context, ProfileSettings(authRepository: widget.authRepository,userStorage: widget.userStorage,));
          },
          icon: gc.settingArrow),
      IconButton(
        onPressed: () {
          navigateToPage(context, getGroupScreen());
        },
        icon: gc.settingArrow,
      ),
      IconButton(
          onPressed: () {
            navigateToPage(context, ChangePassword(authRepository: widget.authRepository,));
          },
          icon: gc.settingArrow),
      Switch(value: isDark(), onChanged: setDarkMode),
      daysOfMonthRadio(),
      LanguageDropDown(),
      const Text(config.projectVersion)
    ];
    return ListViewGeneric(
        leadingWidgets: leadingSettings, trailingWidgets: trailingSettings);
  }


  Widget getGroupScreen() {
    return Container();
  }





  //TODO: read how to add dark mode and add a boolean to track it.
  void setDarkMode(bool isDark) {
      }

  //TODO: create a function that checks if the user has dark mode on
  bool isDark() {
    return gc.darkMode;
  }


  void setDayOfMonth(Object? value) {}

  Widget daysOfMonthRadio() {
    List<String> options = [];
    gc.daysOfMonth.forEach((element) {
      options.add(element.toString());
    });
    UserModel? currentUser =
        UserStorage.instance(AuthRepository.instance()).userData;
    if (currentUser != null) {
      return GenericRadioButton(
          options, PrimitiveWrapper(currentUser.endOfMonthDay.toString()));
    } else {
      return GenericRadioButton(
          options, PrimitiveWrapper(gc.defaultEndOfMonthDay.toString()));
    }
  }
}
