// ================= Transaction Entry =================
import 'package:flutter/material.dart';
import 'package:balance_me/common_models/transaction_model.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/constants.dart' as gc;

class TransactionEntry extends StatefulWidget {
  const TransactionEntry(this._transaction, {Key? key}) : super(key: key);

  final Transaction _transaction;

  @override
  _TransactionEntryState createState() => _TransactionEntryState();
}

class _TransactionEntryState extends State<TransactionEntry> {
  void _openTransactionDetails() {
    // TODO- replace to Details screen after it will be implemented. probably parameters: _transaction and isIncome (take from parent)
    navigateToPage(context, Scaffold());
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(  // TODO- add functionality and Icon for removal
        key: ValueKey<String>(widget._transaction.name),
        child: Column(
          children: [
            Row(
                children: [
                  Text(widget._transaction.name),
                  Text(moneyFormattedString(widget._transaction.amount.toString())),
                  IconButton(
                    onPressed: () => _openTransactionDetails(),
                    icon: const Icon(gc.transactionDetailsIcon),
                  )
                ]
            ),
            Text(widget._transaction.date.toString()),
          ],
        )
    );
  }
}
