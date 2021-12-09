// ================= No Border Text Box =================
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/constants.dart' as gc;

class NoBorderTextBox extends StatefulWidget {
  const NoBorderTextBox(this._controller, this._hintText, {this.hideText = false, this.isNumeric, this.suffix, this.initialValue, this.validatorFunction, this.decoration, Key? key}) : super(key: key);

  final TextEditingController _controller;
  final String? _hintText;
  final bool hideText;
  final bool? isNumeric;
  final Widget? suffix;
  final String? initialValue;
  final StringCallbackStringNullable? validatorFunction;
  final InputDecoration? decoration;

  @override
  _NoBorderTextBoxState createState() => _NoBorderTextBoxState();
}

class _NoBorderTextBoxState extends State<NoBorderTextBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(gc.paddingBetweenText),
      child: TextFormField(
        controller: widget._controller,
        obscureText: widget.hideText,
        keyboardType: widget.isNumeric == true ? TextInputType.number : null,
        inputFormatters: widget.isNumeric == true ? [FilteringTextInputFormatter.digitsOnly] : [],
        initialValue: widget.initialValue?? widget.initialValue,
        validator: widget.validatorFunction,
        decoration: widget.decoration ?? InputDecoration(
          hintText: widget._hintText,
          suffixIcon: widget.suffix,
        ),
      ),
    );
  }
}
