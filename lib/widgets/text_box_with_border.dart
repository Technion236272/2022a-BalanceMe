import 'package:balance_me/localization/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;
Padding emailTextBox(BuildContext context,TextEditingController controllerEmail) {
  return Padding(
    padding:  const EdgeInsets.all(gc.paddingBetweenText),
    child: TextFormField(
      controller: controllerEmail,
      decoration: InputDecoration(
        hintText: Languages.of(context)!.emailText,
        focusedBorder: focusBorder(),
        enabledBorder: focusBorder(),
      ),
    ),
  );
}
Padding passwordTextBox(BuildContext context,bool showPassword,
    TextEditingController controllerPassword,void Function() hideText,[String? text]) {
  return Padding(
    padding: const EdgeInsets.all(gc.paddingBetweenText),
    child: TextFormField(
      obscureText: showPassword,
      controller: controllerPassword,
      decoration: InputDecoration(
          hintText:text==null ?Languages.of(context)!.password:text,
          suffixIcon: IconButton(
            icon:
            Icon(showPassword ? gc.hidePassword : gc.showPassword),
            color: gc.hidePasswordColor,
            onPressed: () {
             hideText();
            },
          ),
          focusedBorder: focusBorder(),
          enabledBorder: focusBorder()),
    ),
  );
}
OutlineInputBorder focusBorder() {
  return OutlineInputBorder(
          borderRadius: BorderRadius.circular(gc.textFieldRadius),
          borderSide: BorderSide(
            color: gc.primaryColor,
            width: gc.borderWidth,
          ),
        );
}

