// ================= Generic icon button widget =================
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;

class GenericIconButton extends StatefulWidget {
  const GenericIconButton({Key? key, this.onTap, this.color, this.iconSize}) : super(key: key);

  final GestureTapCallback? onTap;
  final Color? color;
  final double? iconSize;

  @override
  _GenericIconButtonState createState() => _GenericIconButtonState();
}

class _GenericIconButtonState extends State<GenericIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onTap,
      disabledColor: gc.disabledColor.withOpacity(0.0),
      iconSize: widget.iconSize ?? gc.editIconSize,
      color: widget.color ?? gc.alternativePrimary,
      icon: const Icon(gc.editIcon),
    );
  }
}
