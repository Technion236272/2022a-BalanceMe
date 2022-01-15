// ================= Settings Page =================
import 'package:flutter/material.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:share_plus/share_plus.dart';
import 'package:balance_me/global/rate_us.dart';
import 'package:balance_me/widgets/generic_tooltip.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/pages/authentication/change_password.dart';
import 'package:balance_me/widgets/languages_drop_down.dart';
import 'package:balance_me/widgets/dark_mode_switcher.dart';
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
      GoogleAnalytics.instance.logChangeCurrency(userCurrency);
    }
  }

  TextStyle _getTextDesign() {
    return const TextStyle(color: gc.constantSettingsColor);
  }

  Widget _getDaysOfMonthRadio() {
    return Text(gc.defaultEndOfMonthDay.toString(), style: Theme.of(context).textTheme.bodyText2);
  }

  void _toggleSendEmail(bool? isChecked) {
    if (isChecked != null) {
      setState(() {
        widget.userStorage.updateSendMonthlyReport(isChecked);
      });
      GoogleAnalytics.instance.logToggleSendEmail(isChecked);
    }
  }

  Widget _getSettingsArrow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [
        Icon(gc.settingArrow),
      ],
    );
  }

  void _inviteFriend() {
    Share.share(Languages.of(context)!.strInviteFriendContent.replaceAll("%", gc.googlePlayURL), subject: Languages.of(context)!.strInviteFriendSubject);
    GoogleAnalytics.instance.logInviteFriendOpened();
  }

  void _openRateUs() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => RateUs(),
    );
    GoogleAnalytics.instance.logRateUsOpened();
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
          ListTile(
            leading: Image.asset(
              gc.load,
              height: MediaQuery.of(context).size.height / gc.scalesProportion,
              width: MediaQuery.of(context).size.width / gc.scalesProportion,
            ),
            trailing: Text(Languages.of(context)!.strLoadIcon),
          ),
          const Text(gc.loadLink, style: TextStyle(fontSize: gc.attributeFontSize)),
        ],
    );
  }

  Row leadingWidgetWithInfo(String settingName, String tip) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(settingName),
        GenericTooltip(tip: tip),
      ],
    );
  }

  Widget _getConstantsList() {
    List<Widget?> leadingSettings = [
      Text(
        Languages.of(context)!.strConstants,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      Text(Languages.of(context)!.strInviteFriend),
      Text(Languages.of(context)!.strRateUs),
      Text(Languages.of(context)!.strAbout),
      leadingWidgetWithInfo(Languages.of(context)!.strEndOfMonthSettings, Languages.of(context)!.strEndOfMonthInfo),
      Text(Languages.of(context)!.strVersionSettings),
    ];
    List<Widget?> trailingSettings = [
      null,
      IconButton(
        onPressed: _inviteFriend,
        icon: _getSettingsArrow(),
      ),
      IconButton(
        onPressed: _openRateUs,
        icon: _getSettingsArrow(),
      ),
      IconButton(
        onPressed: _getAbout,
        icon: _getSettingsArrow(),
      ),
      _getDaysOfMonthRadio(),
      Text(config.projectVersion, style: Theme.of(context).textTheme.bodyText2)
    ];
    return ListViewGeneric(
        leadingWidgets: leadingSettings,
        trailingWidgets: trailingSettings,
        isScrollable: false,
    );
  }

  Widget _getSettingsList() {
    List<Widget?> leadingSettings = [
      widget.authRepository.status == AuthStatus.Authenticated ? Text(Languages.of(context)!.strProfile) : null,
      widget.authRepository.status == AuthStatus.Authenticated ? Text(Languages.of(context)!.strPasswordSettings) : null,
      widget.authRepository.status == AuthStatus.Authenticated ? Text(Languages.of(context)!.strCurrencySettings) : null,
      widget.authRepository.status == AuthStatus.Authenticated ? leadingWidgetWithInfo(Languages.of(context)!.strSendMonthlyReport, Languages.of(context)!.strSendMonthlyReportInfo) : null,
      Text(Languages.of(context)!.strLanguageSettings),
      Text(Languages.of(context)!.strDarkModeSettings),
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
      widget.authRepository.status != AuthStatus.Authenticated ? null :
        GenericRadioButton(CurrencySign.values.toList(), _currencyController, onChangeCallback: _changeCurrency),
      widget.authRepository.status != AuthStatus.Authenticated ? null :
        Checkbox(value: widget.userStorage.userData!.sendReport, onChanged: _toggleSendEmail),
      const LanguageDropDown(),
      DarkModeSwitcher(globalIsDarkMode),
    ];

    return ListViewGeneric(leadingWidgets: leadingSettings, trailingWidgets: trailingSettings, isScrollable: false);
  }

  @override
  Widget build(BuildContext context) {
    _currencyController = PrimitiveWrapper(CurrencySign[widget.userStorage.userData == null ? gc.defaultUserCurrency : widget.userStorage.userData!.userCurrency]!);

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children:[
              _getSettingsList(),
              SizedBox(
                height: MediaQuery.of(context).size.height/gc.separateConstantsScale,
              ),
            _getConstantsList()
            ],
          ),
      ),
    );
  }
}
