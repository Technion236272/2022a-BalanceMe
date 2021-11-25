import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/localization/locale_controller.dart';
import 'package:balance_me/localization/languages_controller.dart';

class LanguageDropDown extends StatefulWidget {
  const LanguageDropDown({Key? key}) : super(key: key);

  @override
  State<LanguageDropDown> createState() => _LanguageDropDownState();
}

class _LanguageDropDownState extends State<LanguageDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<LanguageData>(
      hint: Text(Languages.of(context)!.languageName),  // TODO- maybe should be replaced with currentLanguageCode in storage_repo
      onChanged: (LanguageData? language) {
        setState(() {
          changeLanguage(context, language!.languageCode);
        });
      },
      items: LanguageData.languageList().map<DropdownMenuItem<LanguageData>>(
            (e) => DropdownMenuItem<LanguageData>(
              value: e,
              child: Text(e.name),
            ),
      ).toList(),
    );
  }
}
