import 'package:balance_me/localization/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;

class TextBox extends StatefulWidget {
  const TextBox(this.controller,this.hintText,{this.hideText =false,this.suffix,Key? key}) : super(key: key);
final TextEditingController controller;
final bool hideText;
final String? hintText;
final Widget? suffix;
  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(gc.paddingBetweenText),
    child: TextFormField(
      controller: widget.controller,
      obscureText:widget.hideText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        focusedBorder: focusBorder(),
        enabledBorder: focusBorder(),
        suffixIcon: widget.suffix,
      ),
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
}
