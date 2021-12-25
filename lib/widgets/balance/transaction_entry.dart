// ================= Transaction Entry =================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
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
  UserStorage get userStorage => Provider.of<UserStorage>(context, listen: false);

  void _openTransactionDetails() {
    navigateToPage(context, SetTransaction(DetailsPageMode.Details, widget._currentCategory, CurrencySign[userStorage.userData == null ? gc.defaultUserCurrency : userStorage.userData!.userCurrency]!, currentTransaction: widget._transaction), AppPages.SetTransaction);
  }

  void _closeDialogCallback() {
    navigateBack(context);
  }

  Future<void> _confirmRemoval() async {
    await showYesNoAlertDialog(
        context,
        Languages.of(context)!.strVerifyRemoval.replaceAll("%", Languages.of(context)!.strTransaction),
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

  Widget _getTransactionEntryWidget() {
    return Container(
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
                widget._transaction.amount.toMoneyFormat(CurrencySign[userStorage.userData == null ? gc.defaultUserCurrency : userStorage.userData!.userCurrency]!),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: gc.entryPadding, right: gc.entryPadding, bottom: gc.entryPadding),
      child: (userStorage.currentDate != null && userStorage.currentDate!.isSameDate(DateTime.now())) ?
      Dismissible(
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
                  Languages.of(context)!.strDelete.replaceAll("%", Languages.of(context)!.strTransaction),
                  style: const TextStyle(
                    color: gc.secondaryColor,
                  ),
                ),
              ],
            )),
        child: _getTransactionEntryWidget(),
        confirmDismiss: _transactionDismissed,
      ) : _getTransactionEntryWidget(),
    );
  }
}
