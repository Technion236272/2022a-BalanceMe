// ================= Generic icon button widget =================
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;

class GenericIconButton extends StatelessWidget {
  const GenericIconButton({Key? key, this.onTap, this.color, this.iconSize}) : super(key: key);

  final GestureTapCallback? onTap;
  final Color? color;
  final double? iconSize;

  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      disabledColor: gc.disabledColor.withOpacity(0.0),
      iconSize: iconSize ?? gc.editIconSize,
      color: color ?? gc.alternativePrimary,
      icon: const Icon(gc.editIcon),
    );
  }
}
