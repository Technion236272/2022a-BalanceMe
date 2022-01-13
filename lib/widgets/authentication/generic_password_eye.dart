// ================= password eye widget for hiding =================
import 'package:balance_me/global/constants.dart' as gc;
import 'package:flutter/material.dart';

class PasswordEye extends StatefulWidget {
   PasswordEye(this.showPassword,this.hide,{Key? key}) : super(key: key);
bool showPassword;
GestureTapCallback hide;
  @override
  _PasswordEyeState createState() => _PasswordEyeState();
}

class _PasswordEyeState extends State<PasswordEye> {

  IconButton _hidingPasswordEye() {
    return IconButton(
      icon: Icon(widget.showPassword ? gc.hidePassword : gc.showPassword),
      color: gc.hidePasswordColor,
      onPressed: widget.hide,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _hidingPasswordEye();
  }
}
