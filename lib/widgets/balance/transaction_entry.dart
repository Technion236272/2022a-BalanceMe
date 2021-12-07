// ================= Transaction View =================
import 'package:flutter/material.dart';
import 'package:balance_me/common_models/transaction_model.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/constants.dart' as gc;

class TransactionWidget extends StatefulWidget {
  const TransactionWidget(this._transaction, this._isIncome, {Key? key}) : super(key: key);

  final Transaction _transaction;
  final bool _isIncome;

  @override
  _TransactionWidgetState createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> {
  void _openTransactionDetails() {
    // TODO- replace to Details screen after it will be implemented. probably parameters: _transaction and isIncome
    navigateToPage(context, Scaffold());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(widget._transaction.name),
            Text(widget._transaction.amount.toString()), // TODO- add currency
            IconButton(
                onPressed: () => _openTransactionDetails(),
                icon: const Icon(gc.transactionDetailsIcon),
            )
          ]
        ),
        Text(widget._transaction.date.toString()),
      ],
    );
  }
}
