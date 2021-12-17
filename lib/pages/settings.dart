// ================= Settings main page =================
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/pages/change_password.dart';
import 'package:balance_me/widgets/languages_drop_down.dart';
import 'package:balance_me/global/project_config.dart' as config;
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/widgets/generic_listview.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/widgets/profile_settings.dart';

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

  Widget mainSettingsList() {
    List<Widget?> leadingSettings = [
      Text(Languages.of(context)!.profileSettings),
      Text(Languages.of(context)!.passwordSettings),
      Text(Languages.of(context)!.endOfMonthSettings),
      Text(Languages.of(context)!.languageSettings),
      Text(Languages.of(context)!.versionSettings)
    ];
    void goToProfileSettings() {
      navigateToPage(
          context,
          ProfileSettings(
            authRepository: widget.authRepository,
            userStorage: widget.userStorage,
          ));
    }

    void goToChangePassword() {
      navigateToPage(
          context,
          ChangePassword(
            authRepository: widget.authRepository,
          ));
    }

    List<Widget?> trailingSettings = [
      IconButton(
          onPressed: goToProfileSettings, icon: const Icon(gc.settingArrow)),
      IconButton(
          onPressed: goToChangePassword, icon: const Icon(gc.settingArrow)),
      daysOfMonthRadio(),
      const LanguageDropDown(),
      const Text(config.projectVersion)
    ];
    return ListViewGeneric(
        leadingWidgets: leadingSettings, trailingWidgets: trailingSettings);
  }

  Widget daysOfMonthRadio() {
    return Text(gc.defaultEndOfMonthDay.toString());
  }
}
