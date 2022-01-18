// ================= Category Header =================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/pages/set_category.dart';
import 'package:balance_me/pages/set_transaction.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/constants.dart' as gc;

class CategoryHeader extends StatefulWidget {
  const CategoryHeader(this._category, this._isCategoryOpen, this._toggleCategory, this._openCategory, {Key? key}) : super(key: key);

  final Category _category;
  final bool _isCategoryOpen;
  final VoidCallback _toggleCategory;
  final VoidCallback _openCategory;

  @override
  State<CategoryHeader> createState() => _CategoryHeaderState();
}

class _CategoryHeaderState extends State<CategoryHeader> {
  UserStorage get userStorage => Provider.of<UserStorage>(context, listen: false);

  double _getProgressPercentage() {
    double progressPercentage = getPercentage(widget._category.amount, widget._category.expected) / 100;
    if (progressPercentage >= 1) {
      progressPercentage = 1;
    }
    if (progressPercentage <= 0) {
      progressPercentage = 0;
    }
    return progressPercentage.toPrecision();
  }

  void _openAddTransactionPage() {
    navigateToPage(context, SetTransaction(DetailsPageMode.Add, widget._category, callback: widget._openCategory), AppPages.SetTransaction);
  }

  void _openCategoryDetails() {
    navigateToPage(context, SetCategory(DetailsPageMode.Details, widget._category.isIncome, currentCategory: widget._category), AppPages.SetCategory);
  }

  void _removeCategory() {
    userStorage.removeCategory(widget._category);
    displaySnackBar(context, Languages.of(context)!.strRemoveSucceeded.replaceAll("%", Languages.of(context)!.strCategory));
  }

  Future<void> _confirmRemoval() async {
    await showYesNoAlertDialog(
        context,
        Languages.of(context)!.strVerifyRemoval.replaceAll("%", Languages.of(context)!.strCategory),
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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(children: [
        Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: gc.categoryHeaderPadding, right: gc.categoryHeaderPadding),
                  child: Text(
                    widget._category.name,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: userStorage.currentDate != null && userStorage.currentDate!.isSameDate(DateTime.now()),
                    child: IconButton(
                      iconSize: gc.iconSize,
                      padding: const EdgeInsets.fromLTRB(gc.iconHorizontalPadding,gc.iconVerticalPadding,gc.iconHorizontalPadding,gc.iconVerticalPadding),
                      constraints: const BoxConstraints(),
                      color: Theme.of(context).hoverColor,
                      onPressed: _openAddTransactionPage,
                      icon: const Icon(gc.addIcon),
                    ),
                  ),
                  IconButton(
                    iconSize: gc.iconSize,
                    padding: const EdgeInsets.fromLTRB(gc.iconHorizontalPadding,gc.iconVerticalPadding,gc.iconHorizontalPadding,gc.iconVerticalPadding),
                    constraints: const BoxConstraints(),
                    color: Theme.of(context).hoverColor,
                    onPressed: _openCategoryDetails,
                    icon: const Icon(gc.detailsIcon),
                  ),
                  Visibility(
                    visible: userStorage.currentDate != null && userStorage.currentDate!.isSameDate(DateTime.now()),
                    child: IconButton(
                      iconSize: gc.iconSize,
                      padding: widget._category.transactions.isNotEmpty
                          ? const EdgeInsets.fromLTRB(gc.iconHorizontalPadding,gc.iconVerticalPadding,gc.iconHorizontalPadding,gc.iconVerticalPadding)
                      : const EdgeInsets.fromLTRB(gc.iconHorizontalPadding,gc.iconVerticalPadding,gc.iconHorizontalPadding,gc.iconVerticalPadding),
                      constraints: const BoxConstraints(),
                      color: Theme.of(context).hoverColor,
                      onPressed: _confirmRemoval,
                      icon: const Icon(gc.deleteIcon),
                    ),
                  ),
                  Visibility(
                    visible: widget._category.transactions.isNotEmpty,
                    child: IconButton(
                        iconSize: gc.iconSize,
                        padding: const EdgeInsets.fromLTRB(gc.iconHorizontalPadding,gc.iconVerticalPadding,gc.iconHorizontalPadding,gc.iconVerticalPadding),
                        constraints: const BoxConstraints(),
                        color: Theme.of(context).hoverColor,
                        onPressed: widget._toggleCategory,
                        icon: Icon(
                            widget._isCategoryOpen
                            ? gc.expandIcon
                            : gc.minimizeIcon
                        )
                    ),
                  )
                ],
              ),
            ]),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(
                right: gc.categoryAroundPadding,
                left: gc.categoryAroundPadding,
                bottom: gc.categoryAroundPadding),
            child: Text(
              widget._category.amount.toMoneyFormat(CurrencySign[userStorage.userData == null ? gc.defaultUserCurrency : userStorage.userData!.userCurrency]!) +
                  gc.inPracticeExpectedSeparator +
                  widget._category.expected.toMoneyFormat(CurrencySign[userStorage.userData == null ? gc.defaultUserCurrency : userStorage.userData!.userCurrency]!),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(
                right: gc.categoryAroundPadding,
                left: gc.categoryAroundPadding,
                bottom: gc.categoryAroundPadding),
            child: LinearPercentIndicator(
              animation: true,
              lineHeight: gc.lineBarHeight,
              animationDuration: gc.lineAnimationDuration,
              percent: _getProgressPercentage(),
              center: Text((_getProgressPercentage() * 100).toPrecision().toPercentageFormat()),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Theme.of(context).toggleableActiveColor,
            ),
          ),
        ),
        Visibility(
            visible: widget._isCategoryOpen && widget._category.transactions.isNotEmpty,
            child: const Padding(
              padding: EdgeInsets.only(bottom: gc.categoryAroundPadding),
              child: Divider()
            ))
      ]),
    );
  }
}
