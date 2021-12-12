// ================= Category Complex =================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/common_models/transaction_model.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/widgets/balance/transaction_entry.dart';
import 'package:balance_me/widgets/balance/category_header.dart';
import 'package:balance_me/global/utils.dart';

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

  void _removeTransaction(Transaction transaction) {
    Provider.of<UserStorage>(context, listen: false).removeTransaction(widget._category, transaction, null);
    displaySnackBar(context, Languages.of(context)!.removeSucceeded.replaceAll("%", Languages.of(context)!.transaction));
  }

  List<Widget> getTransactions() {
    List<Widget> transactionWidgets = [];
    for (var transaction in widget._category.transactions) {
      transactionWidgets.add(TransactionEntry(transaction, _removeTransaction, widget._category.isIncome));
    }
    return transactionWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          CategoryHeader(widget._category, _isCategoryOpen, _toggleCategory),
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
