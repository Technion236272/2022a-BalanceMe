// ================= Form Text Field =================
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/constants.dart' as gc;

class FormTextField  extends StatelessWidget {
  const FormTextField (this._controller, this._minLines, this._maxLines, this._hintText, {this.isBordered = false, this.isValid = false,
    this.isNumeric = false, this.initialValue, this.isEnabled = true, this.validatorFunction, this.autofocus = false, Key? key}) : super(key: key);

  final TextEditingController? _controller;
  final int _minLines;
  final int _maxLines;
  final String _hintText;
  final bool isBordered;
  final bool isValid;
  final bool isNumeric;
  final String? initialValue;
  final bool isEnabled;
  final StringCallbackStringNullable? validatorFunction;
  final bool autofocus;

  UnderlineInputBorder underlineFocus(BuildContext context) {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).toggleableActiveColor),
    );
  }

  UnderlineInputBorder underlineUnFocus(BuildContext context) {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: gc.dividerColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      autofocus: autofocus,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.multiline,
      minLines: _minLines,
      maxLines: _maxLines,
      inputFormatters: isNumeric ? [numberFormatter(true)] : [],
      textDirection: getTextDirection(Languages.of(context)!.languageDirection),
      decoration: InputDecoration(
        hintText: _hintText,
        border: isBordered ? null : underlineUnFocus(context),
        focusedBorder: isBordered ? null : underlineFocus(context),
        enabledBorder: isBordered ? null : underlineUnFocus(context),
      ),
      textAlign: isValid ? TextAlign.center : TextAlign.start,
      initialValue: initialValue,
      enabled: isEnabled,
      validator: isValid ? validatorFunction : null,
      style: isBordered ? null : TextStyle(
          fontSize: gc.inputFontSize,
      ),
    );
  }
}
