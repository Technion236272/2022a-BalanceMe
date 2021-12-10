// ================= Transaction Entry =================
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/common_models/transaction_model.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/constants.dart' as gc;

class TransactionEntry extends StatefulWidget {
  const TransactionEntry(this._transaction, this._removeTransactionCB, {Key? key}) : super(key: key);

  final Transaction _transaction;
  final VoidCallbackTransaction _removeTransactionCB;

  @override
  _TransactionEntryState createState() => _TransactionEntryState();
}

class _TransactionEntryState extends State<TransactionEntry> {
  void _openTransactionDetails() {
    // TODO
  }

  void _editTransaction() {
    // TODO
  }

  void _closeDialogCallback() {
    navigateBack(context);
  }

  Future<void> _confirmRemoval() async {
    await showYesNoAlertDialog(
        context,
        Languages.of(context)!.verifyRemoval.replaceAll("%", Languages.of(context)!.transaction),
        _confirmRemovalCallback,
        _closeDialogCallback);
  }

  void _confirmRemovalCallback() {
    widget._removeTransactionCB(widget._transaction);
    _closeDialogCallback();
  }

  Future<bool?> _transactionDismissed(DismissDirection direction) async {
    await _confirmRemoval();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey<String>(widget._transaction.name),
      background: Container(
          color: gc.primaryColor,
          child: Row(
            children: <Widget>[
              const Icon(
                gc.deleteIcon,
                color: gc.secondaryColor,
              ),
              Text(
                Languages.of(context)!.delete.replaceAll("%", Languages.of(context)!.transaction),
                style: const TextStyle(
                  color: gc.secondaryColor,
                ),
              ),
            ],
          )),
      child: Column(
        children: [
          Row(
            children: [
              Text(widget._transaction.name),
              Text(widget._transaction.amount.toMoneyFormat()),
              IconButton(
                onPressed: _openTransactionDetails,
                icon: const Icon(gc.transactionDetailsIcon),
              ),
              IconButton(
                onPressed: _confirmRemoval,
                icon: const Icon(gc.deleteIcon),
              ),
            ],
          ),
          Text(widget._transaction.date.toString()),
        ],
      ),
      confirmDismiss: _transactionDismissed,
    );
  }
}
