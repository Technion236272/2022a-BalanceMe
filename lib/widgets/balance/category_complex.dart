// ================= Category Complex =================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/common_models/transaction_model.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/widgets/balance/transaction_entry.dart';
import 'package:balance_me/widgets/balance/category_header.dart';

class CategoryComplex extends StatefulWidget {
  const CategoryComplex(this._category, {Key? key}) : super(key: key);

  final Category _category;

  @override
  _CategoryComplexState createState() => _CategoryComplexState();
}

class _CategoryComplexState extends State<CategoryComplex> {
  bool _isCategoryOpen = false;

  void _toggleCategory() {
    setState(() {
      _isCategoryOpen = !_isCategoryOpen;
    });
  }

  void _addTransaction(Transaction transaction) {
    setState(() {
      widget._category.addTransaction(transaction);
    });
    Provider.of<UserStorage>(context, listen: false).SEND_balanceModel();
  }

  void _removeTransaction(Transaction transaction) {
    setState(() {
      widget._category.removeTransaction(transaction);
    });
    Provider.of<UserStorage>(context, listen: false).SEND_balanceModel();
  }

  List<Widget> getTransactions() {
    List<Widget> transactionWidgets = [];
    for (var transaction in widget._category.transactions) {
      transactionWidgets.add(TransactionEntry(transaction, _removeTransaction));
    }
    return transactionWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          CategoryHeader(widget._category, _isCategoryOpen, _toggleCategory, _addTransaction),
          _isCategoryOpen ?  // TODO- add animation
          Column(
            children: getTransactions(),
          )
          : Container(),
        ],
      ),
    );
  }
}
