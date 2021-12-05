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
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(gc.textFieldRadius),
            borderSide: BorderSide(
              color: gc.primaryColor,
              width: gc.borderWidth,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(gc.textFieldRadius),
            borderSide: BorderSide(
              color: gc.primaryColor,
              width: gc.borderWidth,
            ),
          )),
    ),
  );
}

