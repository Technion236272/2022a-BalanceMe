// ================= Language Drop Down Widget =================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/localization/locale_controller.dart';
import 'package:balance_me/localization/languages_controller.dart';

class LanguageDropDown extends StatefulWidget {
  const LanguageDropDown({Key? key}) : super(key: key);

  @override
  State<LanguageDropDown> createState() => _LanguageDropDownState();
}

class _LanguageDropDownState extends State<LanguageDropDown> {
  void _onChangeLanguage(LanguageData? language) {
    setState(() {
      changeLanguage(context, language!.languageCode);
    });
    Provider.of<UserStorage>(context, listen: false).setLanguage(language!.languageCode);
    Provider.of<UserStorage>(context, listen: false).SEND_generalInfo();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<LanguageData>(
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
