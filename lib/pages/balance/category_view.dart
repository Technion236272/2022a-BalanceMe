// ================= Category View =================
import 'package:flutter/material.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/pages/balance/transaction_view.dart';
import 'package:balance_me/widgets/category_header.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget(this._category, {Key? key}) : super(key: key);

  final Category _category;

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  bool _isCategoryOpen = false;

  List<Widget> getTransactionWidgets() {
    List<Widget> transactionWidgets = [];
    for (var transaction in widget._category.transactions) {
      transactionWidgets.add(TransactionWidget(transaction, widget._category.isIncome));
    }
    return transactionWidgets;
  }

  void _toggleCategory() {
    setState(() {
      _isCategoryOpen = !_isCategoryOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(  // TODO- add design, don't forget update widget after adding or removing
      child: Column(
        children: [
          CategoryHeader(widget._category.name, widget._category.expected, widget._category.inPractice, _isCategoryOpen, _toggleCategory),
          _isCategoryOpen ?  // TODO- add animation
          Column(
            children: getTransactionWidgets(),
          )
          : Container(),
        ],
      ),
    );
  }
}
