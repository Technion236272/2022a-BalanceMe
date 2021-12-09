// ================= Action Button =================
import 'package:flutter/material.dart';


/// This is a widget for button that after action will be became to a progress indicator.
/// the widget receives:
/// a bool or function that returns a bool that determine if loading should be seen.
/// text for presenting on the button.
/// callback to be executed after clicking on the button.
/// [optional] ButtonStyle for styling the button.
class ActionButton extends StatelessWidget {
  const ActionButton(this._showLoading, this._textButton, this._onPressedCallback, {this.style, Key? key}) : super(key: key);

  final dynamic _showLoading;
  final String _textButton;
  final VoidCallback _onPressedCallback;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return (_showLoading.runtimeType == bool ? _showLoading : _showLoading()) ?
    const Center(
      child: CircularProgressIndicator(),
    )
    : ElevatedButton(
      child: Text(_textButton),
      onPressed: _onPressedCallback,
      style: style,
    );
  }
}
