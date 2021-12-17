// ================= Transaction Entry =================
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/common_models/transaction_model.dart';
import 'package:balance_me/pages/set_transaction.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/constants.dart' as gc;

class TransactionEntry extends StatefulWidget {
  const TransactionEntry( this._currentCategory, this._transaction, this._removeTransactionCB, this._isIncome, {Key? key}) : super(key: key);

  final Category _currentCategory;
  final Transaction _transaction;
  final bool _isIncome;
  final VoidCallbackTransaction _removeTransactionCB;

  @override
  _TransactionEntryState createState() => _TransactionEntryState();
}

class _TransactionEntryState extends State<TransactionEntry> {
  void _openTransactionDetails() {
    navigateToPage(context, SetTransaction(DetailsPageMode.Details, widget._currentCategory, currentTransaction: widget._transaction), AppPages.SetTransaction);
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
    return Padding(
      padding: const EdgeInsets.only(left: gc.entryPadding, right: gc.entryPadding, bottom: gc.entryPadding),
      child: Dismissible(
        key: ValueKey<String>(widget._transaction.name),
        background: Container(
            decoration: BoxDecoration(
              color: gc.primaryColor,
              borderRadius: BorderRadius.circular(gc.entryBorderRadius),
            ),
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
        child: Container(
          decoration: BoxDecoration(
              color: gc.entryColor,
              boxShadow: [
                BoxShadow(
                  color: gc.entryShadow,
                  spreadRadius: gc.shadowDesignConstant,
                  blurRadius: gc.shadowDesignConstant,
                  offset: const Offset(gc.shadowDesignConstant, gc.shadowDesignConstant), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(gc.entryBorderRadius),
              border: Border.all(color: widget._isIncome ? gc.incomeEntryColor : gc.expenseEntryColor),
          ),
          child: ListTile(
            title: Text(
              widget._transaction.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(widget._transaction.date),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                    child: Text(
                        widget._transaction.amount.toMoneyFormat(),
                        style: TextStyle(fontWeight: FontWeight.bold,
                        color: widget._isIncome ? gc.incomeEntryColor : gc.expenseEntryColor),
                    ),
                ),
                Center(
                  child: IconButton(
                    onPressed: _openTransactionDetails,
                    icon: const Icon(gc.transactionDetailsIcon),
                  ),
                ),
              ],
            ),
          ),
        ),
        confirmDismiss: _transactionDismissed,
      ),
    );
  }
}
