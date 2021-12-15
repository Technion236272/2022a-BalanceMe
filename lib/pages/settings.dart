// ================= Settings main page =================
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/change_password.dart';
import 'package:balance_me/widgets/languages_drop_down.dart';
import 'package:balance_me/global/project_config.dart' as config;
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/widgets/generic_listview.dart';
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

  }

  Widget mainSettingsList() {
    List<Widget?> leadingSettings = [
      Text(Languages.of(context)!.profileSettings),
      // Text(Languages.of(context)!.groupSettings),
      Text(Languages.of(context)!.passwordSettings),
      // Text(Languages.of(context)!.darkModeSettings),
      Text(Languages.of(context)!.endOfMonthSettings),
      Text(Languages.of(context)!.languageSettings),
      Text(Languages.of(context)!.versionSettings)
    ];
    // bool hasGroup()
    // {
    //   return widget.authRepository.isAuthenticated && widget.userStorage.userData!=null;
    //
    // }
    List<Widget?> trailingSettings = [
      IconButton(
          onPressed: () {
            navigateToPage(context, ProfileSettings(authRepository: widget.authRepository,userStorage: widget.userStorage,));
          },
          icon: Icon(gc.settingArrow)),
      // IconButton(
      //   onPressed: () {
      //
      //     hasGroup()?navigateToPage(context, GroupScreen(authRepository: widget.authRepository,userStorage: widget.userStorage,)):
      //     navigateToPage(context, CreateJoinGroup());
      //   },
      //   icon: gc.settingArrow,
      // ),
      IconButton(
          onPressed: () {
            navigateToPage(context, ChangePassword(authRepository: widget.authRepository,));
          },
          icon: const Icon(gc.settingArrow)),
      // Switch(value: isDark(), onChanged: setDarkMode),
      daysOfMonthRadio(),
      const LanguageDropDown(),
      const Text(config.projectVersion)
    ];
    return ListViewGeneric(
        leadingWidgets: leadingSettings, trailingWidgets: trailingSettings);
  }

  void setDayOfMonth(Object? value) {}

  Widget daysOfMonthRadio() {
    // List<String> options = [];
    // gc.daysOfMonth.forEach((element) {
    //   options.add(element.toString());
    // });
    // UserModel? currentUser =
    //     UserStorage.instance(AuthRepository.instance()).userData;
    // if (currentUser != null) {
    //   return GenericRadioButton(
    //       options, PrimitiveWrapper(currentUser.endOfMonthDay.toString()));
    // } else {
    //   return GenericRadioButton(
    //       options, PrimitiveWrapper(gc.defaultEndOfMonthDay.toString()));
    // }
    return Text(gc.defaultEndOfMonthDay.toString());
  }
}
