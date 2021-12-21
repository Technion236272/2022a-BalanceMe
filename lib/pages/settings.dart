// ================= Settings Page =================
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
  const Settings(this.authRepository, this.userStorage, {Key? key}) : super(key: key);

  final AuthRepository authRepository;
  final UserStorage userStorage;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void _openProfileSettings() {
    navigateToPage(context, ProfileSettings(authRepository: widget.authRepository, userStorage: widget.userStorage), AppPages.Profile);
  }

  void _openChangePassword() {
    navigateToPage(context, ChangePassword(authRepository: widget.authRepository), AppPages.ChangePassword);
  }

  TextStyle _getTextDesign() {
    return const TextStyle(color: gc.constantSettingsColor);
  }

  Widget _getDaysOfMonthRadio() {
    return Text(gc.defaultEndOfMonthDay.toString(), style: _getTextDesign());
  }

  Widget _getSettingsArrow() {
    return const Padding(
      padding: EdgeInsets.only(left: gc.padSettingsArrow),
      child: Icon(gc.settingArrow),
    );
  }

  Widget _getSettingsList() {
    List<Widget?> leadingSettings = [
      widget.authRepository.status == AuthStatus.Authenticated ? Text(Languages.of(context)!.profileSettings) : null,
      widget.authRepository.status == AuthStatus.Authenticated ? Text(Languages.of(context)!.passwordSettings) : null,
      Text(Languages.of(context)!.endOfMonthSettings),
      Text(Languages.of(context)!.languageSettings),
      Text(Languages.of(context)!.versionSettings)
    ];

    List<Widget?> trailingSettings = [
      widget.authRepository.status != AuthStatus.Authenticated ? null :
      IconButton(
          onPressed: _openProfileSettings,
          icon: _getSettingsArrow(),
      ),

      widget.authRepository.status != AuthStatus.Authenticated ? null :
      IconButton(
          onPressed: _openChangePassword,
          icon: _getSettingsArrow(),
      ),

      _getDaysOfMonthRadio(),
      const LanguageDropDown(),
      Text(config.projectVersion, style: _getTextDesign())
    ];

    return ListViewGeneric(leadingWidgets: leadingSettings, trailingWidgets: trailingSettings, isScrollable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getSettingsList(),
    );
  }
}
