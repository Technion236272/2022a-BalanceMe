// ================= Text box with an (optional) border widget =================
import 'package:flutter/material.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/constants.dart' as gc;

/// The widget receives the following parameters-
/// controller- to attach to the text, for functions
/// hintText- the text which will tell the user what to type - vanishes on tap
/// hideText-  optional, if you want to hide the text (passwords, for example)
/// labelText- optional, the text which shows in the text box, until tapped, then above it.
/// haveborder- optional, whether you want to create a border around your text box
/// suffix-optional,the widget that is shown at the end of the text box
/// textBoxHeight-optional, the height of the text box (specified in the height parameter)
/// textBoxSize-optional inner padding in the text box which will increase its size- for longer text
class TextBox extends StatefulWidget {
  const TextBox(this.controller, this.hintText, {this.hideText = false, this.labelText, this.haveBorder = true,
    this.suffix, this.textBoxHeight, this.textBoxSize, this.validatorFunction, Key? key}) : super(key: key);

  final TextEditingController controller;
  final bool hideText;
  final String? hintText;
  final Widget? labelText;
  final Widget? suffix;
  final bool haveBorder;
  final double? textBoxHeight;
  final EdgeInsetsGeometry? textBoxSize;
  final StringCallbackStringNullable? validatorFunction;

  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.textBoxHeight,
      child: Padding(
        padding: const EdgeInsets.all(gc.paddingBetweenText),
        child: TextFormField(
          controller: widget.controller,
          validator: widget.validatorFunction,
          obscureText: widget.hideText,
          decoration: InputDecoration(
            contentPadding: widget.textBoxSize,
            hintText: widget.hintText,
            label: widget.labelText,
            focusedBorder: widget.haveBorder ? focusBorder() : null,
            enabledBorder: widget.haveBorder ? focusBorder() : null,
            errorBorder: widget.haveBorder ? focusBorder() : null,
            suffixIcon: widget.suffix,
          ),
        ),
      ),
    );
  }

  OutlineInputBorder focusBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(gc.textFieldRadius),
      borderSide: const BorderSide(
        color: gc.primaryColor,
        width: gc.borderWidth,
      ),
    );
  }
}
