// ================= Generic icon button widget =================
import 'package:balance_me/global/constants.dart' as gc;
import 'package:flutter/material.dart';

class GenericIconButton extends StatefulWidget {
  const GenericIconButton({Key? key, this.onTap}) : super(key: key);
  final GestureTapCallback? onTap;

  @override
  _GenericIconButtonState createState() => _GenericIconButtonState();
}

class _GenericIconButtonState extends State<GenericIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onTap,
      icon: const Icon(
        gc.editPencil,
        color: gc.alternativePrimary,
      ),
    );
  }
}
