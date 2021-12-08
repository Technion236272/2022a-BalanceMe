// ================= Balance Page =================
import 'package:flutter/material.dart';
import 'package:balance_me/pages/balance/balance_model.dart';
import 'package:balance_me/widgets/balance/categories_type.dart';

class BalancePage extends StatelessWidget {
  const BalancePage(this._balanceModel, this._saveBalanceModelCB, {Key? key}) : super(key: key);

  final BalanceModel _balanceModel;
  final VoidCallback _saveBalanceModelCB;

  @override
  Widget build(BuildContext context) {
    return Column(  // TODO- change to tabs
      children: [
        _balanceModel.incomeCategories != [] ? CategoriesType(_balanceModel.incomeCategories, _saveBalanceModelCB) : Container(),
        _balanceModel.expensesCategories != [] ? CategoriesType(_balanceModel.expensesCategories, _saveBalanceModelCB) : Container(),
      ],
    );
  }
}
