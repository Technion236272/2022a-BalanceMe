// ================= No Border Text Box =================
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;

class NoBorderTextBox extends StatefulWidget {
  const NoBorderTextBox(this._controller, this._hintText, {this.hideText = false, this.isMultiline, this.suffix, this.initialValue, this.decoration, Key? key}) : super(key: key);

  final TextEditingController _controller;
  final String? _hintText;
  final bool hideText;
  final bool? isMultiline;
  final Widget? suffix;
  final String? initialValue;
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
        keyboardType: widget.isMultiline == true ? TextInputType.multiline : null,
        initialValue: widget.initialValue?? widget.initialValue,
        decoration: widget.decoration ?? InputDecoration(
          hintText: widget._hintText,
          suffixIcon: widget.suffix,
        ),
      ),
    );
  }
}
