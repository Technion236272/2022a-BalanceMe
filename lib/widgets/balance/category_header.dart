// ================= Category Header =================
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/pages/set_transaction.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/constants.dart' as gc;

class CategoryHeader extends StatelessWidget {
  const CategoryHeader(this._category, this._isCategoryOpen, this._toggleCategory, this._saveTransactionCallback, {Key? key}) : super(key: key);

  final Category _category;
  final bool _isCategoryOpen;
  final VoidCallback _toggleCategory;
  final VoidCallbackTransaction _saveTransactionCallback;

  @override
  Widget build(BuildContext context) {
    double progressPercentage = getPercentage(_category.amount, _category.expected);

    return Column(
        children: [
          Row(
            children: [
              Text(_category.name),
              Text(moneyFormattedString(_category.amount.toString()) + gc.inPracticeExpectedSeperator + moneyFormattedString(_category.expected.toString())),
              IconButton(
                  onPressed: () {
                    navigateToPage(context, SetTransaction(_saveTransactionCallback));
                  },
                  icon: const Icon(gc.addIcon),
              ),
              IconButton(
                onPressed: _toggleCategory,
                icon: Icon(_isCategoryOpen ? gc.expandIcon : gc.minimizeIcon),
              )
            ],
          ),
          Padding(  // TODO- consider if Padding is necessary and put all constants in gc
            padding: const EdgeInsets.all(15.0),
            child: LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 50,
              animation: true,
              lineHeight: 20.0,
              animationDuration: 2500,
              percent: progressPercentage,
              center: Text(percentageFormattedString(progressPercentage.toString())),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: gc.primaryColor,
            ),
          ),
        ]
    );
  }
}
