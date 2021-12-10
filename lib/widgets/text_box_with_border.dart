// ================= Border Text Box =================
import 'package:flutter/material.dart';
import 'package:balance_me/widgets/text_box_without_border.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/constants.dart' as gc;

class BorderTextBox extends StatelessWidget {
  const BorderTextBox(this._controller, this._hintText, {this.hideText = false, this.suffix, this.isNumeric, this.initialValue, this.validatorFunction, Key? key}) : super(key: key);

  final TextEditingController _controller;
  final String? _hintText;
  final bool hideText;
  final bool? isNumeric;
  final String? initialValue;
  final Widget? suffix;
  final StringCallbackStringNullable? validatorFunction;

  OutlineInputBorder focusBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(gc.textFieldRadius),
      borderSide: BorderSide(
        color: gc.primaryColor,
        width: gc.borderWidth,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NoBorderTextBox(_controller, _hintText,
        hideText: hideText,
        suffix: suffix,
        isNumeric: isNumeric,
        initialValue: initialValue,
        validatorFunction: validatorFunction,
        decoration: InputDecoration(
          hintText: _hintText,
          focusedBorder: focusBorder(),
          enabledBorder: focusBorder(),
          suffixIcon: suffix,
        ));
  }
}
