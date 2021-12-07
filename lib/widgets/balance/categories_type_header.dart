// ================= Categories Type Header =================
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/widgets/ring_pie_chart.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/constants.dart' as gc;

class CategoriesTypeHeader extends StatelessWidget {
  const CategoriesTypeHeader(this._categories, {Key? key}) : super(key: key);

  final List<Category> _categories;

  List<Json> _getChartDataFromCategories() {
    List<Json> chartData = [];
    for (var category in _categories) {
      chartData.add({gc.pieChartNameJson: category.name, gc.pieChartPercentageJson: category.totalAmount});
    }
    return chartData;
  }

  double _getTotalCategoriesListAmount(bool isExpected) {
    double totalAmount = 0;
    for (var category in _categories) {
      totalAmount += isExpected ? category.expected : category.totalAmount;
    }
    return totalAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RingPieChart(_getChartDataFromCategories(), true, null),
        Card(
          child: Row(
            children: [
              Column(
                children: [
                  Text(Languages.of(context)!.now),
                  Text(moneyFormattedString(_getTotalCategoriesListAmount(true).toString())),
                ],
              ),
              Column(
                children: [
                  Text(Languages.of(context)!.expected),
                  Text(moneyFormattedString(_getTotalCategoriesListAmount(false).toString())),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
