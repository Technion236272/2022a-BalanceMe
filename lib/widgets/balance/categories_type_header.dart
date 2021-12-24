// ================= Categories Type Header =================
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/widgets/ring_pie_chart.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/constants.dart' as gc;

class CategoriesTypeHeader extends StatelessWidget {
  const CategoriesTypeHeader(this._categories, {Key? key}) : super(key: key);

  final List<Category> _categories;

  double _getTotalCategoriesListAmount(bool isExpected) {
    double totalAmount = 0;
    for (var category in _categories) {
      totalAmount += isExpected ? category.expected : category.amount;
    }
    return totalAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RingPieChart(_categories, true, null),
        Card(
          shadowColor: gc.primaryColor.withOpacity(0.5),
          elevation: gc.cardElevationHeight,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
                color: gc.primaryColor, width: gc.cardBorderWidth),
            borderRadius: BorderRadius.circular(gc.entryBorderRadius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(gc.categoryTopPadding),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: gc.categoryAroundPadding),
                      child: Text(
                        Languages.of(context)!.current,
                        style: TextStyle(
                            color: gc.disabledColor,
                            fontSize: gc.fontSizeLoginImage,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(_getTotalCategoriesListAmount(false).toMoneyFormat(),
                        style: TextStyle(
                            color: (_categories.elementAt(0).isIncome && _getTotalCategoriesListAmount(false)>=_getTotalCategoriesListAmount(true))
                                    ? gc.incomeEntryColor
                                    : (!_categories.elementAt(0).isIncome && _getTotalCategoriesListAmount(true)>_getTotalCategoriesListAmount(false))
                                    ? gc.incomeEntryColor
                                    : gc.expenseEntryColor,
                            fontSize: gc.fontSizeLoginImage,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(gc.categoryTopPadding),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: gc.categoryAroundPadding),
                      child: Text(Languages.of(context)!.expected,
                          style: TextStyle(
                              color: gc.disabledColor,
                              fontSize: gc.fontSizeLoginImage,
                              fontWeight: FontWeight.bold,
                          ),
                      ),
                    ),
                    Text(_getTotalCategoriesListAmount(true).toMoneyFormat(),
                        style: const TextStyle(
                            color: gc.primaryColor,
                            fontSize: gc.fontSizeLoginImage,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
