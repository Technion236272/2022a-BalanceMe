// ================= Category Header =================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/common_models/transaction_model.dart';
import 'package:balance_me/pages/set_category.dart';
import 'package:balance_me/pages/set_transaction.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/constants.dart' as gc;

class CategoryHeader extends StatefulWidget {
  const CategoryHeader(this._category, this._isCategoryOpen, this._toggleCategory, {Key? key}) : super(key: key);

  final Category _category;
  final bool _isCategoryOpen;
  final VoidCallback _toggleCategory;

  @override
  State<CategoryHeader> createState() => _CategoryHeaderState();
}

class _CategoryHeaderState extends State<CategoryHeader> {

  void _addTransaction(Transaction transaction) {
    Provider.of<UserStorage>(context, listen: false).addTransaction(widget._category, transaction);
    displaySnackBar(context, Languages.of(context)!.removeSucceeded.replaceAll("%", Languages.of(context)!.transaction));
  }

  void _openAddTransactionPage() {
    navigateToPage(context, SetTransaction(_addTransaction));
  }

  void _openCategoryDetails() {
    navigateToPage(context, SetCategory(DetailsPageMode.Details, Provider.of<UserStorage>(context, listen: false).editCategory, widget._category.isIncome, currentCategory: widget._category));
  }

  void _removeCategory() {
    Provider.of<UserStorage>(context, listen: false).removeCategory(widget._category);
    displaySnackBar(context, Languages.of(context)!.removeSucceeded.replaceAll("%", Languages.of(context)!.category));
  }

  Future<void> _confirmRemoval() async {
    await showYesNoAlertDialog(
        context,
        Languages.of(context)!.verifyRemoval.replaceAll("%", Languages.of(context)!.category),
        _confirmRemovalCallback,
        _closeDialogCallback);
  }

  void _confirmRemovalCallback() {
    _removeCategory();
    _closeDialogCallback();
  }

  void _closeDialogCallback() {
    navigateBack(context);
  }

  @override
  Widget build(BuildContext context) {
    double progressPercentage = getPercentage(widget._category.amount, widget._category.expected) / 100;
    progressPercentage = (progressPercentage >= 1) ? 1 : progressPercentage.toPrecision();

    return Column(children: [
      Row(
        children: [
          Text(widget._category.name),
          Text(widget._category.amount.toMoneyFormat() +
              gc.inPracticeExpectedSeparator +
              widget._category.expected.toMoneyFormat()),
          IconButton(
            onPressed: _openAddTransactionPage,
            icon: const Icon(gc.addIcon),
          ),
          IconButton(
            onPressed: _openCategoryDetails,
            icon: const Icon(gc.transactionDetailsIcon),
          ),
          IconButton(
            onPressed: _confirmRemoval,
            icon: const Icon(gc.deleteIcon),
          ),
          widget._category.transactions.isNotEmpty ?
              IconButton(
                  onPressed: widget._toggleCategory,
                  icon: Icon(widget._isCategoryOpen ? gc.expandIcon : gc.minimizeIcon))
              : Container(),
        ],
      ),
      Padding(
        // TODO- consider if Padding is necessary and put all constants in gc
        padding: const EdgeInsets.all(15.0),
        child: LinearPercentIndicator(
          width: MediaQuery.of(context).size.width - 50,
          animation: true,
          lineHeight: 20.0,
          animationDuration: 2500,
          percent: progressPercentage,
          center:
              Text((progressPercentage * 100).toPercentageFormat()),
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: gc.primaryColor,
        ),
      ),
    ]);
  }
}
