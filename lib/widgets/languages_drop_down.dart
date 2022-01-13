// ================= Language Drop Down Widget =================
import 'package:balance_me/global/types.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/localization/locale_controller.dart';
import 'package:balance_me/localization/languages_controller.dart';
import 'package:balance_me/global/utils.dart';

class LanguageDropDown extends StatefulWidget {
  const LanguageDropDown({Key? key}) : super(key: key);

  @override
  State<LanguageDropDown> createState() => _LanguageDropDownState();
}

class _LanguageDropDownState extends State<LanguageDropDown> {
  UserStorage get userStorage => Provider.of<UserStorage>(context, listen: false);

  void _closeDialogCallback() {
    navigateBack(context);
  }

  void _onChangeLanguage(LanguageData? language) async {
    void _changeLanguageCallback() {
      _changeLanguage(language);
      _closeDialogCallback();
    }

    if (Provider.of<AuthRepository>(context, listen: false).status != AuthStatus.Authenticated && !userStorage.balance.isEmpty) {
      await showYesNoAlertDialog(
          context,
          Languages.of(context)!.strBeforeChangeAlertDialogContent.replaceAll("%", Languages.of(context)!.strLanguage),
          _changeLanguageCallback,
          _closeDialogCallback
      );
    } else {
      _changeLanguage(language);
    }
  }

  void _changeLanguage(LanguageData? language) {
    if (language != null) {
      setState(() {
        changeLanguage(context, language.languageCode);
      });

      if (userStorage.userData != null) {
        userStorage.userData!.language = language.languageCode;
        userStorage.SEND_generalInfo();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<LanguageData>(
      dropdownColor: Theme.of(context).cardColor,
      hint: Text(Languages.of(context)!.languageName),
      onChanged: _onChangeLanguage,
      items: LanguageData.languageList().map<DropdownMenuItem<LanguageData>>(
            (e) => DropdownMenuItem<LanguageData>(
              value: e,
              child: Text(e.name),
            ),
      ).toList(),
    );
  }
}
