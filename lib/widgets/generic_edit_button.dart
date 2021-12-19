// ================= Generic icon button widget =================
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;

class GenericIconButton extends StatelessWidget {
  const GenericIconButton({Key? key, this.onTap, this.color, this.iconSize, this.isDisabled=false}) : super(key: key);

  final GestureTapCallback? onTap;
  final Color? color;
  final double? iconSize;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed:isDisabled? null :onTap,
      disabledColor: gc.disabledColor.withOpacity(gc.disabledOpacity),
      iconSize: iconSize ?? gc.editIconSize,
      color: color ?? gc.alternativePrimary,
      icon: const Icon(gc.editIcon),
    );
  }
}
