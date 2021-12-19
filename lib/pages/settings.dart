// ================= Settings main page =================
import 'package:flutter/material.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/pages/change_password.dart';
import 'package:balance_me/widgets/languages_drop_down.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/widgets/generic_listview.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/widgets/profile_settings.dart';
import 'package:balance_me/global/config.dart' as config;
import 'package:balance_me/global/constants.dart' as gc;

class Settings extends StatefulWidget {
  const Settings(this.authRepository, this.userStorage, {Key? key})
      : super(key: key);
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
  }

  void navigateToProfileSettings() {
    navigateToPage(context, ProfileSettings(authRepository: widget.authRepository, userStorage: widget.userStorage), AppPages.Profile);
  }

  void navigateToChangePassword() {
    navigateToPage(context, ChangePassword(authRepository: widget.authRepository), AppPages.ChangePassword);
  }

  Widget mainSettingsList() {
    List<Widget?> leadingSettings = [
      Text(Languages.of(context)!.profileSettings),
      Text(Languages.of(context)!.passwordSettings),
      Text(Languages.of(context)!.endOfMonthSettings),
      Text(Languages.of(context)!.languageSettings),
      Text(Languages.of(context)!.versionSettings)
    ];

    List<Widget?> trailingSettings = [
      IconButton(
          onPressed: navigateToProfileSettings,
          icon: settingsArrow()
      ),
      IconButton(
          onPressed: navigateToChangePassword,
          icon: settingsArrow()
      ),
      daysOfMonthRadio(),
      const LanguageDropDown(),
       Text(config.projectVersion,style: textDesign())
    ];

    return ListViewGeneric(
        leadingWidgets: leadingSettings, trailingWidgets: trailingSettings);
  }

  Widget daysOfMonthRadio() {
    return Text(gc.defaultEndOfMonthDay.toString(),style: textDesign(),);
  }

  Widget settingsArrow() {
    return const Padding(
      padding: EdgeInsets.only(left: gc.padSettingsArrow),
      child: Icon(gc.settingArrow),
    );
  }

  TextStyle textDesign() {
    return const TextStyle(color: gc.constantSettingsColor);
  }
}
