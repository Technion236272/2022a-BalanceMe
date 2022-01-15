// ================= Generic Delete Dismissible =================
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/constants.dart' as gc;

class GenericDeleteDismissible extends StatefulWidget {
  const GenericDeleteDismissible(this._key, this._type, this._child, {this.removeCallback, Key? key}) : super(key: key);

  final String _key;
  final String _type;
  final Widget _child;
  final VoidCallback? removeCallback;

  @override
  State<GenericDeleteDismissible> createState() => _GenericDeleteDismissibleState();
}

class _GenericDeleteDismissibleState extends State<GenericDeleteDismissible> {
  void _closeDialogCallback() {
    navigateBack(context);
  }

  Future<void> _confirmRemoval() async {
    await showYesNoAlertDialog(
        context,
        Languages.of(context)!.strVerifyRemoval.replaceAll("%", widget._type),
        _confirmRemovalCallback,
        _closeDialogCallback);
  }

  void _confirmRemovalCallback() {
    if (widget.removeCallback != null) {
      widget.removeCallback!();
    }
    _closeDialogCallback();
  }

  Future<bool?> _onDismissed(DismissDirection direction) async {
    await _confirmRemoval();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey<String>(widget._key),
      child: widget._child,
      confirmDismiss: _onDismissed,
      background: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).toggleableActiveColor,
          borderRadius: BorderRadius.circular(gc.entryBorderRadius),
        ),
        child: Row(
          children: [
            const Icon(
              gc.deleteIcon,
              color: gc.secondaryColor,
            ),
            Text(
              Languages.of(context)!.strDelete.replaceAll("%", widget._type),
              style: TextStyle(
                color: gc.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
