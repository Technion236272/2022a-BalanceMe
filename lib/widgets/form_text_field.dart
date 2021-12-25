// ================= Form Text Field =================
import 'package:balance_me/global/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/constants.dart' as gc;

class FormTextField  extends StatelessWidget {
  const FormTextField (this._controller, this._minLines, this._maxLines, this._hintText, {this.isBordered = false, this.isValid = false,
    this.isNumeric = false, this.initialValue, this.isEnabled = true, this.validatorFunction,this.currencySign = '', Key? key}) : super(key: key);

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
  final String currencySign;

  OutlineInputBorder focusBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(gc.textFieldRadius),
      borderSide: BorderSide(
        color: gc.primaryColor,
        width: gc.borderWidth,
      ),
    );
  }

  void _onTap(){
    if(_controller != null && isNumeric){
      _controller!.clear();
      _controller!.text = currencySign;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.multiline,
      inputFormatters: isNumeric == true ? [FilteringTextInputFormatter.allow(gc.floatNumber), CurrencyFormatter(currencySign)] : [],
      minLines: _minLines,
      maxLines: _maxLines,
      decoration: InputDecoration(
        hintText: _hintText,
        hintStyle: gc.defaultHintStyle,
        border: isBordered ? focusBorder() : null,
        focusedBorder: isBordered ? focusBorder() : null,
        enabledBorder: isBordered ? focusBorder() : null,
        errorBorder: isBordered ? focusBorder() : null,
      ),
      textAlign: isValid ? TextAlign.center : TextAlign.start,
      initialValue: initialValue,
      enabled: isEnabled,
      validator: isValid ? validatorFunction : null,
      onTap: _onTap,
      style: isBordered ? null : TextStyle(
          fontSize: gc.inputFontSize,
          color: gc.inputFontColor
      ),
    );
  }
}
