// ================= Settings Page =================
import 'package:flutter/material.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/pages/authentication/change_password.dart';
import 'package:balance_me/widgets/languages_drop_down.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/widgets/generic_listview.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/pages/profile_settings.dart';
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [
        Icon(gc.settingArrow),
      ],
    );
  }

  void _getAbout() {
    showAboutDialog(
        context: context,
        applicationName: Languages.of(context)!.strAppName,
        applicationVersion: config.projectVersion,
        applicationLegalese: Languages.of(context)!.strLegalese,
        children: [
          ListTile(
            leading: Image.asset(
                gc.balanceImage,
                height: MediaQuery.of(context).size.height / gc.scalesProportion,
                width: MediaQuery.of(context).size.width / gc.scalesProportion,
            ),
            trailing: Text(Languages.of(context)!.strScalesIcon),
          ),
          const Text(gc.scalesLink, style: TextStyle(fontSize: gc.attributeFontSize)),
        ],
    );
  }

  Widget _getSettingsList() {
    List<Widget?> leadingSettings = [
      widget.authRepository.status == AuthStatus.Authenticated ? Text(Languages.of(context)!.strProfile) : null,
      widget.authRepository.status == AuthStatus.Authenticated ? Text(Languages.of(context)!.strPasswordSettings) : null,
      Text(Languages.of(context)!.strCurrencySettings),
      Text(Languages.of(context)!.strEndOfMonthSettings),
      Text(Languages.of(context)!.strLanguageSettings),
      Text(Languages.of(context)!.strAbout),
      Text(Languages.of(context)!.strVersionSettings)
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

      Text(CurrencySign[widget.userStorage.userData == null ? gc.defaultUserCurrency : widget.userStorage.userData!.userCurrency]!, style: _getTextDesign()),
      _getDaysOfMonthRadio(),
      const LanguageDropDown(),

      IconButton(
        onPressed: _getAbout,
        icon: _getSettingsArrow(),
      ),

      Text(config.projectVersion, style: _getTextDesign())
    ];

    return ListViewGeneric(leadingWidgets: leadingSettings, trailingWidgets: trailingSettings, isScrollable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: _getSettingsList(),
      ),
    );
  }
}
