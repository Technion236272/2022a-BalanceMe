// ================= Balance Page =================
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/common_models/balance_model.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/widgets/balance/categories_type.dart';
import 'package:balance_me/widgets/generic_tabs.dart';
import 'package:balance_me/widgets/generic_info.dart';
import 'package:balance_me/global/types.dart';

class BalancePage extends StatelessWidget {
  BalancePage(this._balanceModel, this._changeCurrentTab, {Key? key}) : super(key: key) {
    GoogleAnalytics.instance.logPageOpened(AppPages.Balance);
  }

  final BalanceModel _balanceModel;
  final VoidCallbackInt _changeCurrentTab;

  Widget _getTabBarView(BuildContext context, List<Category> categoriesList){
    return categoriesList.isNotEmpty ? CategoriesType(categoriesList) : GenericInfo(null, Languages.of(context)!.nothingToShow, null);
  }

  @override
  Widget build(BuildContext context) {
    return TabGeneric(
      getGenericTabs([Languages.of(context)!.incomes, Languages.of(context)!.expenses]),
      [
        _getTabBarView(context, _balanceModel.incomeCategories),
        _getTabBarView(context, _balanceModel.expensesCategories),
      ],
      onSwitch: _changeCurrentTab,
    );
  }
}
