import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;

class TextBox extends StatefulWidget {
  const TextBox(this.controller,this.hintText,{this.hideText =false,this.labelText,this.haveBorder=true,this.suffix,this.textBoxHeight,
    this.textBoxSize,Key? key}) : super(key: key);
final TextEditingController controller;
final bool hideText;
final String? hintText;
final Widget? labelText;
final Widget? suffix;
final bool haveBorder;
final double? textBoxHeight;
final EdgeInsetsGeometry? textBoxSize;

  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.textBoxHeight,
      child: Padding(padding: const EdgeInsets.all(gc.paddingBetweenText),
      child: TextFormField(
        controller: widget.controller,
        obscureText:widget.hideText,
        decoration: InputDecoration(
          contentPadding:widget.textBoxSize ,
          hintText: widget.hintText,
          label: widget.labelText,
          focusedBorder:widget.haveBorder? focusBorder():null,
          enabledBorder:widget.haveBorder? focusBorder():null,
          suffixIcon: widget.suffix,
        ),
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
