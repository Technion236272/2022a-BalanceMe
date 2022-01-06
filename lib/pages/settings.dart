// ================= Settings Page =================
import 'package:balance_me/widgets/generic_tooltip.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:balance_me/widgets/generic_radio_button.dart';
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
  late PrimitiveWrapper _currencyController;

  void _openProfileSettings() {
    navigateToPage(context, ProfileSettings(authRepository: widget.authRepository, userStorage: widget.userStorage), AppPages.Profile);
  }

  void _openChangePassword() {
    navigateToPage(context, ChangePassword(authRepository: widget.authRepository), AppPages.ChangePassword);
  }

  void _changeCurrency() {
    if (widget.userStorage.userData != null) {
      Currency userCurrency = CurrencySign.keys.firstWhere((i) => CurrencySign[i] == _currencyController.value);
      widget.userStorage.userData!.userCurrency = userCurrency;
      if (widget.authRepository.status == AuthStatus.Authenticated) {
        widget.userStorage.SEND_generalInfo();
      }
    }
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

  Row leadingWidgetWithInfo(String settingName, String tip) {
    return Row(

      mainAxisSize: MainAxisSize.min,
      children: [
        GenericTooltip(
          tip: tip,
        ),
        Text(settingName),
      ],
    );
  }

  Widget _getConstantsList() {
    List<Widget?> leadingSettings = [
      Text(
        Languages.of(context)!.strConstants,
        style: _getTextDesign(),
      ),
      leadingWidgetWithInfo(
          Languages.of(context)!.strAbout, Languages.of(context)!.strAboutInfo),
      leadingWidgetWithInfo(Languages.of(context)!.strEndOfMonthSettings,
          Languages.of(context)!.strEndOfMonthInfo),
      leadingWidgetWithInfo(Languages.of(context)!.strVersionSettings,
          Languages.of(context)!.strVersionInfo),
    ];
    List<Widget?> trailingSettings = [
      null,
      IconButton(
        onPressed: _getAbout,
        icon: _getSettingsArrow(),
      ),
      _getDaysOfMonthRadio(),
      Text(config.projectVersion, style: _getTextDesign())
    ];
    return ListViewGeneric(
        leadingWidgets: leadingSettings,
        trailingWidgets: trailingSettings,
        isScrollable: false);
  }

  Widget _getSettingsList() {
    List<Widget?> leadingSettings = [
      widget.authRepository.status == AuthStatus.Authenticated ?leadingWidgetWithInfo(Languages.of(context)!.strProfile,
          Languages.of(context)!.strProfileInfo) :null,
      widget.authRepository.status == AuthStatus.Authenticated ? leadingWidgetWithInfo(Languages.of(context)!.strPasswordSettings,
          Languages.of(context)!.strPasswordChangeInfo) : null,
      leadingWidgetWithInfo(Languages.of(context)!.strCurrencySettings, Languages.of(context)!.strCurrencyInfo),
      leadingWidgetWithInfo(Languages.of(context)!.strLanguageSettings, Languages.of(context)!.strLanguageInfo),
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
      GenericRadioButton(CurrencySign.values.toList(), _currencyController, onChangeCallback: _changeCurrency),
      const LanguageDropDown(),

    ];

    return ListViewGeneric(leadingWidgets: leadingSettings, trailingWidgets: trailingSettings, isScrollable: false);
  }

  @override
  Widget build(BuildContext context) {
    _currencyController = PrimitiveWrapper(CurrencySign[widget.userStorage.userData == null ? gc.defaultUserCurrency : widget.userStorage.userData!.userCurrency]!);

    return Scaffold(
      body: SingleChildScrollView(
          child: Column( children:[_getSettingsList(),
              Divider(
                height: MediaQuery.of(context).size.height/gc.separateConstantsScale,
                color: gc.secondaryColor,
              ),
            _getConstantsList()], ),
      ),
    );
  }
}
