// ================= Balance Page =================
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/pages/balance/balance_model.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/widgets/balance/categories_type.dart';
import 'package:balance_me/widgets/generic_tabs.dart';
import 'package:balance_me/global/types.dart';

class BalancePage extends StatelessWidget {
  const BalancePage(this._balanceModel, this._changeCurrentTab, {Key? key}) : super(key: key);

  final BalanceModel _balanceModel;
  final VoidCallbackInt _changeCurrentTab;

  Widget _getTabBarView(List<Category> categoriesList){
    return categoriesList.isNotEmpty ? CategoriesType(categoriesList) : Container();  // TODO- create "Nothing To Show Here page"
  }

  @override
  Widget build(BuildContext context) {
    return TabGeneric(
      getGenericTabs([Languages.of(context)!.incomes, Languages.of(context)!.expenses]),
      [
        _getTabBarView(_balanceModel.incomeCategories),
        _getTabBarView(_balanceModel.expensesCategories),
      ],
      onSwitch: _changeCurrentTab,
    );
  }
}
