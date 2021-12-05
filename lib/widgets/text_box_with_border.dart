import 'package:balance_me/localization/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;
Padding emailTextBox(BuildContext context,TextEditingController controllerEmail) {
  return Padding(
    padding:  const EdgeInsets.all(gc.paddingBetweenText),
    child: TextFormField(
      controller: controllerEmail,
      // onChanged: (String? value) {
      //   email = value;
      // },
      decoration: InputDecoration(
        hintText: Languages.of(context)!.emailText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(gc.textFieldRadius),
          borderSide: BorderSide(
            color: gc.primaryColor,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(gc.textFieldRadius),
          borderSide: BorderSide(
            color: gc.primaryColor,
            width: 2.0,
          ),
        ),
      ),
    ),
  );
}
