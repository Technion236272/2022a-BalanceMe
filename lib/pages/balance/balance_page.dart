// ================= Balance Page =================
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/pages/summary.dart';
import 'package:balance_me/widgets/balance/add_category_button.dart';
import 'package:balance_me/common_models/balance_model.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/widgets/balance/categories_type.dart';
import 'package:balance_me/widgets/generic_tabs.dart';
import 'package:balance_me/widgets/generic_info.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/constants.dart' as gc;

class BalancePage extends StatelessWidget {
  BalancePage(this._balanceModel, this._changeCurrentTab, {Key? key}) : super(key: key);

  final BalanceModel _balanceModel;
  final VoidCallbackInt _changeCurrentTab;

  Widget _getTabBarView(BuildContext context, List<Category> categoriesList){
    return categoriesList.isNotEmpty ? CategoriesType(categoriesList)
        : Column(
      children: [
        AddCategoryButton(gc.defaultCategoryType == BalanceTabs.Incomes),
        GenericInfo(bottomInfo: Languages.of(context)!.strNothingToShow)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return TabGeneric(
      getGenericTabs([Languages.of(context)!.strSummary, Languages.of(context)!.strExpenses, Languages.of(context)!.strIncomes]),
      [
        SummaryPage(this._balanceModel),
        _getTabBarView(context, _balanceModel.expensesCategories),
        _getTabBarView(context, _balanceModel.incomeCategories),
      ],
      onSwitch: _changeCurrentTab,
    );
  }
}
