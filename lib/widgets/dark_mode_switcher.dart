// ================= Dark Mode Switcher Widget =================
import 'package:balance_me/global/types.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/global/utils.dart';

class DarkModeSwitcher extends StatefulWidget {
  const DarkModeSwitcher({Key? key}) : super(key: key);

  @override
  State<DarkModeSwitcher> createState() => _DarkModeSwitcherState();
}

class _DarkModeSwitcherState extends State<DarkModeSwitcher> {
  UserStorage get userStorage => Provider.of<UserStorage>(context, listen: false);

  void _closeDialogCallback() {
    navigateBack(context);
  }

  void _onSetTheme(bool isDarkMode) async {
    void _changeLanguageCallback() {
      _setTheme(isDarkMode);
      _closeDialogCallback();
    }

    if (Provider.of<AuthRepository>(context, listen: false).status != AuthStatus.Authenticated && !userStorage.balance.isEmpty) {
      await showYesNoAlertDialog(
          context,
          Languages.of(context)!.strBeforeChangeAlertDialogContent.replaceAll("%", Languages.of(context)!.strTheme),
          _changeLanguageCallback,
          _closeDialogCallback
      );
    } else {
      _setTheme(isDarkMode);
    }
  }

  void _setTheme(bool isDarkMode) {
    setState(() {
      userStorage.setTheme(context, isDarkMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Switch(value: globalIsDarkMode, onChanged: _onSetTheme);
  }
}
